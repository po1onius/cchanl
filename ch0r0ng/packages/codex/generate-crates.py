#!/usr/bin/env python3
"""Turn `guix import crate --lockfile=... codex` output into a channel module."""
from pathlib import Path
import re
import sys

raw = Path(sys.argv[1]).read_text()
definitions = re.findall(r'^\(define .*?(?=^\(define |\Z)', raw, re.M | re.S)
registry = []
git = []
kept = []
seen_git = set()
for definition in definitions:
    symbol = re.search(r'^\(define ([^\s]+)', definition)[1]
    if '(method git-fetch)' in definition:
        url = re.search(r'\(url "([^"]+)"\)', definition)[1]
        commit = re.search(r'\(commit "([^"]+)"\)', definition)[1]
        if (url, commit) in seen_git:
            continue
        seen_git.add((url, commit))
        label = 'git-' + url.rstrip('/').split('/')[-1].removesuffix('.git')
        git.append((label, symbol))
        definition = definition.replace(';; TODO REVIEW: Define standalone package if this is a workspace.',
            ';; Kept as a complete Git tree; the Guile build phase resolves workspace paths.')
    else:
        registry.append(symbol)
    kept.append(definition.rstrip())

header = ''';;; Generated from Codex 0.154.0 Cargo.lock with `guix import crate`.
;;; See ch0r0ng/packages/codex/README.md for the regeneration procedure.
(define-module (ch0r0ng packages codex crates)
  #:use-module (guix build-system cargo)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:export (%codex-crate-sources %codex-git-sources))

'''
out = header + '\n\n'.join(kept)
out += '\n\n(define %codex-crate-sources\n  (list\n'
out += ''.join('    ' + symbol + '\n' for symbol in registry) + '    ))\n'
out += '\n(define %codex-git-sources\n  (list\n'
out += ''.join(f'    (cons "{label}" {symbol})\n' for label, symbol in git) + '    ))\n'
Path(sys.argv[2]).write_text(out)
print(f'Generated {len(registry)} registry sources and {len(git)} Git trees.')
