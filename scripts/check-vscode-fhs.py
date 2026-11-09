#!/usr/bin/env python3
"""Smoke-test a built vscode-fhs; optionally test an installed extension binary.

Usage: python3 scripts/check-vscode-fhs.py STORE_PATH [EXTENSION_EXECUTABLE]
The optional subprocess test requires node on PATH.  No editor settings change.
"""

import hashlib
import os
from pathlib import Path
import subprocess
import sys
import tempfile


def main():
    root = Path(sys.argv[1]).resolve()
    runner = str(root / "bin/vscode-fhs-run")
    host_loader = Path("/lib64/ld-linux-x86-64.so.2").exists()
    with tempfile.TemporaryDirectory(prefix="vscode-fhs-test-") as temporary:
        subprocess.run(
            [str(root / "bin/code"), "--user-data-dir=" + temporary, "--version"],
            check=True,
        )
        result = subprocess.run(
            [runner, "/usr/bin/env", "/bin/sh", "-c",
             'test -d /usr/lib && test "$CCHANL_FHS_TEST" = preserved && '
             'printf "%s\\n%s\\n" "$HOME" "$PWD"'],
            env=dict(os.environ, CCHANL_FHS_TEST="preserved"),
            text=True, capture_output=True, check=True,
        )
        assert result.stdout.splitlines() == [os.environ["HOME"], os.getcwd()]
        marker = Path(temporary) / "shared"
        subprocess.run([runner, "/usr/bin/touch", str(marker)], check=True)
        assert marker.exists()
        assert subprocess.run([runner, "/bin/sh", "-c", "exit 42"]).returncode == 42

    if len(sys.argv) > 2:
        plugin = Path(sys.argv[2]).resolve()
        before = hashlib.sha256(plugin.read_bytes()).digest()
        subprocess.run([runner, str(plugin), "--version"], check=True)
        # Match how a VS Code extension starts its language server.
        script = """
const cp = require('child_process');
const result = cp.spawnSync(process.argv[1], ['--version'], {encoding: 'utf8'});
if (result.error) throw result.error;
process.stdout.write(result.stdout);
process.stderr.write(result.stderr);
process.exit(result.status ?? 1);
"""
        subprocess.run([runner, "node", "-e", script, str(plugin)], check=True)
        assert before == hashlib.sha256(plugin.read_bytes()).digest()

    assert host_loader == Path("/lib64/ld-linux-x86-64.so.2").exists()
    desktops = list((root / "share/applications").glob("*.desktop"))
    assert len(desktops) == 2
    for desktop in desktops:
        assert "Exec=" + str(root / "bin/code") in desktop.read_text()
    assert (root / "share/icons/hicolor/512x512/apps/vscode.png").is_file()
    print("PASS: CLI, FHS runtime, shared environment/files, exit status, desktop entries")


if __name__ == "__main__":
    main()
