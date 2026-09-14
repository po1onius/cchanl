#!/usr/bin/env python3
"""Adapt the pinned service sources to Guix-managed paths and processes."""
from pathlib import Path
import json
import shutil
import sys
import tomllib


def replace(file, before, after, count=1):
    path = Path(file)
    text = path.read_text()
    assert text.count(before) == count, (file, before, text.count(before))
    path.write_text(text.replace(before, after))


# Preserve registry checksums when retaining Cargo.lock.  Guix's default stub
# omits the package checksum and is only suitable after removing the lockfile.
checksums = {(p["name"], p["version"]): p["checksum"]
             for p in tomllib.loads(Path("Cargo.lock").read_text())["package"]
             if p.get("source", "").startswith("registry+")}
for manifest in Path("guix-vendor").glob("*/Cargo.toml"):
    package = tomllib.loads(manifest.read_text())["package"]
    checksum = checksums[(package["name"], package["version"])]
    (manifest.parent / ".cargo-checksum.json").write_text(
        json.dumps({"package": checksum, "files": {}}))


logger = Path("../guix-clash-verge-logger").resolve()
shutil.copytree(sys.argv[1], logger)
for path in [logger, *logger.rglob("*")]:
    path.chmod(path.stat().st_mode | 0o200)
replace("Cargo.toml",
        'git = "https://github.com/clash-verge-rev/clash-verge-logger.git"',
        f'path = "{logger}"')

# The GUI binary retains its upstream /tmp/verge paths.  The system service
# installs a root-owned compatibility symlink to this root-owned /run directory.
replace("src/lib.rs", '"/tmp/verge/clash-verge-service.sock"',
        '"/run/clash-verge-rev/clash-verge-service.sock"')
replace("src/core/server.rs", "Permissions::from_mode(0o777)",
        "Permissions::from_mode(0o660)")

# Directory ownership is established by Shepherd, never by IPC clients or a
# watchdog guessing the interactive user's group.  Keep O_NOFOLLOW validation.
path = Path("src/core/server.rs")
text = path.read_text()
start = text.index("    let gid = resolve_ipc_dir_gid();")
end = text.index("    unsafe {\n        platform_lib::close(fd);", start)
text = text[:start] + "    let result: std::io::Result<()> = Ok(());\n" + text[end:]
text = text.replace("meta.gid() != resolve_ipc_dir_gid()", "false")
path.write_text(text)

# Apply policy at the shared start entry point, including watchdog and persisted
# state recovery.  In production client-supplied executable/socket paths never
# reach Command::new, chmod, or unlink.  Upstream tests retain their mock cores.
replace("src/core/manager.rs",
        "    pub async fn start_core(&self, config: ClashConfig) -> Result<()> {",
        '''    pub async fn start_core(&self, config: ClashConfig) -> Result<()> {
        #[cfg(not(feature = "test"))]
        let config = {
            let mut config = config;
            config.core_config.core_path = env!("GUIX_MIHOMO").to_string();
            config.core_config.core_ipc_path =
                "/run/clash-verge-rev/verge-mihomo.sock".to_string();
            config
        };''')
replace("src/core/manager.rs", "Permissions::from_mode(0o777)",
        "Permissions::from_mode(0o660)")
replace("src/core/manager.rs", "Permissions set to 777", "Permissions set to 660")

# SIGKILL skips Mihomo's TUN cleanup, including policy routing rules.  Wait for
# normal termination before falling back to a forced kill of an unresponsive core.
replace("src/core/manager.rs", "pub struct ChildGuard {", '''async fn terminate_child(child: &mut Child) -> std::io::Result<()> {
    #[cfg(unix)]
    if let Some(pid) = child.id() {
        if unsafe { platform_lib::kill(pid as platform_lib::pid_t, platform_lib::SIGTERM) } == 0 {
            match tokio::time::timeout(Duration::from_secs(5), child.wait()).await {
                Ok(result) => return result.map(|_| ()),
                Err(_) => warn!("Core did not exit after SIGTERM; forcing termination"),
            }
        }
    }
    child.kill().await
}

pub struct ChildGuard {''')
# Restrict the replacement to the original two calls, excluding our fallback.
replace("src/core/manager.rs", "if let Err(e) = child.kill().await {",
        "if let Err(e) = terminate_child(&mut child).await {", count=2)

# /writer and desired-state recovery must use the same log policy as /start.
replace("src/core/logger.rs", ".directory(config.directory.clone())", '''.directory({
                #[cfg(not(feature = "test"))]
                { "/var/log/clash-verge-service".to_string() }
                #[cfg(feature = "test")]
                { config.directory.clone() }
            })''')

# A service started by an interactive administrator should use the same state
# directory as one started at boot, irrespective of inherited HOME/XDG values.
replace("src/core/paths.rs", '''        if let Some(path) = std::env::var_os("XDG_STATE_HOME") {
            return PathBuf::from(path).join(SERVICE_NAME);
        }

        if let Some(home) = std::env::var_os("HOME") {
            return PathBuf::from(home)
                .join(".local")
                .join("state")
                .join(SERVICE_NAME);
        }

''', "")
