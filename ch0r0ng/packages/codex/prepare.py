#!/usr/bin/env python3
"""Prepare locked upstream Git dependencies for a network-free Cargo build."""
from pathlib import Path
import os
import re
import shutil
import sys
import tomllib

# Executed with cwd=codex-rs, after registry crates have been unpacked.
# Outside codex-rs: Cargo otherwise infers path dependencies are members of
# the Codex workspace and resolves their workspace inheritance against it.
git_root = Path('../guix-git').resolve()
git_root.mkdir()
package_paths = {}
manifests = []
for source in map(Path, sys.argv[1:]):
    target = git_root / source.name
    shutil.copytree(source, target, symlinks=True)
    target.chmod(target.stat().st_mode | 0o200)
    for path in target.rglob('*'):
        if not path.is_symlink():
            path.chmod(path.stat().st_mode | 0o200)
    for manifest in target.rglob('Cargo.toml'):
        data = tomllib.loads(manifest.read_text())
        name = data.get('package', {}).get('name')
        if name:
            package_paths[name] = str(manifest.parent)
        manifests.append(manifest)

# Keep Git workspaces intact, including inherited versions and relative paths.
# Registry crates remain exactly the versions supplied by upstream Cargo.lock.
manifests.extend(p for p in Path('.').rglob('Cargo.toml')
                 if not p.is_relative_to('guix-vendor') and not p.is_relative_to('guix-git'))
pattern = re.compile(r'^(\s*[\w-]+\s*=\s*)(\{[^\n]*\bgit\s*=[^\n]*\})', re.M)
for manifest in manifests:
    def replace(match):
        prefix, table = match.groups()
        entry = tomllib.loads('dependency = ' + table)['dependency']
        name = entry.get('package', prefix.split('=')[0].strip())
        if name not in package_paths:
            return match.group()
        path = package_paths[name]
        table = re.sub(r'\bgit\s*=\s*"[^"]*"', 'path = "' + path + '"', table)
        table = re.sub(r'\b(?:rev|branch|tag)\s*=\s*"[^"]*"\s*,?\s*', '', table)
        table = re.sub(r',\s*}', ' }', table)
        return prefix + table
    def replace_table(match):
        header, body = match.groups()
        if not re.search(r'^git\s*=', body, re.M):
            return match.group()
        entry = tomllib.loads(body)
        name = entry.get('package', header.rstrip(']').rsplit('.', 1)[-1].strip('"'))
        if name not in package_paths:
            return match.group()
        body = re.sub(r'^git\s*=\s*"[^"]*"',
                      'path = "' + package_paths[name] + '"', body, flags=re.M)
        body = re.sub(r'^(?:rev|branch|tag)\s*=.*\n', '', body, flags=re.M)
        return header + '\n' + body
    original = manifest.read_text()
    updated = pattern.sub(replace, original)
    updated = re.sub(r'^(\[[^\n]+\])\n(.*?)(?=^\[|\Z)',
                     replace_table, updated, flags=re.M | re.S)
    tomllib.loads(updated)
    if updated != original:
        manifest.write_text(updated)

# Use Guix's protoc rather than the prebuilt executable in protoc-bin-vendored.
build_script = Path('code-mode-protocol/build.rs')
text = build_script.read_text()
assert 'protoc_bin_vendored::protoc_bin_path()?' in text
build_script.write_text(text.replace('protoc_bin_vendored::protoc_bin_path()?',
    'PathBuf::from("' + os.environ['PROTOC'] + '")'))

# Permit read-only access to the Guix store just as upstream does for Nix.
for name in ('linux-sandbox/src/bwrap.rs', 'utils/path-utils/src/system_commands.rs'):
    path = Path(name)
    text = path.read_text()
    assert '"/nix/store",' in text
    path.write_text(text.replace('"/nix/store",', '"/nix/store",\n    "/gnu/store",'))

# Resolve fallback shells on both Guix System and foreign distributions.
path = Path('shell-command/src/shell_detect.rs')
text = path.read_text()
text = text.replace('&["/bin/bash", "/usr/bin/bash"]',
                    '&["' + os.environ['GUIX_BASH'] + '", "/bin/bash", "/usr/bin/bash"]')
text = text.replace('&["/bin/sh"]',
                    '&["' + os.environ['GUIX_SH'] + '", "/bin/sh"]')
path.write_text(text)
print(f'Prepared {len(package_paths)} packages from locked Git trees.')
