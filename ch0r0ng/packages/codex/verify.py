#!/usr/bin/env python3
"""Exercise installed helpers offline, without credentials or audio devices."""
from pathlib import Path
import json
import os
import select
import shutil
import struct
import subprocess
import sys
import tempfile
import time

root = Path(sys.argv[1]).resolve()
commit = '6b9826e3aa83b1a5947db50f4332cb9c65f1b340'


class Host:
    def __init__(self, command, endian, env):
        self.endian = endian
        self.log = tempfile.TemporaryFile()
        self.process = subprocess.Popen(command, stdin=subprocess.PIPE,
                                        stdout=subprocess.PIPE, stderr=self.log,
                                        env=env, bufsize=0)

    def send(self, message):
        data = json.dumps(message).encode()
        self.process.stdin.write(struct.pack(self.endian + 'I', len(data)) + data)
        self.process.stdin.flush()

    def read_bytes(self, length):
        data = b''
        deadline = time.monotonic() + 30
        while len(data) < length:
            remaining = deadline - time.monotonic()
            if remaining <= 0 or not select.select([self.process.stdout], [], [], remaining)[0]:
                raise TimeoutError('helper response timed out')
            chunk = os.read(self.process.stdout.fileno(), length - len(data))
            if not chunk:
                self.log.seek(0)
                raise RuntimeError('helper exited: ' + self.log.read().decode(errors='replace'))
            data += chunk
        return data

    def receive(self):
        length, = struct.unpack(self.endian + 'I', self.read_bytes(4))
        assert length <= 16 * 1024 * 1024, length
        return json.loads(self.read_bytes(length))

    def close(self):
        self.process.stdin.close()
        try:
            self.process.wait(timeout=10)
        except subprocess.TimeoutExpired:
            self.process.kill()
            self.process.wait()
        self.log.close()


with tempfile.TemporaryDirectory(prefix='.codex-guix-check-', dir=Path.home()) as home:
    Path(home, '.codex').mkdir()
    env = dict(os.environ, HOME=home, CODEX_HOME=home + '/.codex')
    cli = str(root / 'bin/codex')
    version = subprocess.check_output([cli, '--version'], env=env, text=True).strip()
    assert version == 'codex-cli 0.154.0', version
    for args in (['--help'], ['exec', '--help'], ['sandbox', '--help']):
        subprocess.run([cli, *args], env=env, stdout=subprocess.DEVNULL, check=True)
    print(version + ': CLI checks passed', flush=True)

    shell = str(Path(shutil.which('sh')).resolve())
    sandbox = subprocess.run(
        [cli, 'sandbox', '-P', ':read-only', '-C', home, '--', shell, '-c',
         'test -r "$1" && printf guix-sandbox-ok; '
         'if printf forbidden > "$2" 2>/dev/null; then exit 91; fi',
         'sh', shell, str(Path(home, 'must-not-create'))],
        env=env, capture_output=True, text=True, timeout=30)
    assert sandbox.returncode == 0, sandbox.stderr
    assert sandbox.stdout == 'guix-sandbox-ok', sandbox.stdout
    assert not Path(home, 'must-not-create').exists()
    print('Linux sandbox: store shell works and forbidden writes are blocked', flush=True)

    host = Host([str(root / 'codex-resources/codex-code-mode-host'), '--listen', 'stdio'], '<', env)
    try:
        host.send({'type': 'connection/hello', 'supportedVersions': [1],
                   'requiredCapabilities': [], 'optionalCapabilities': []})
        ready = host.receive()
        assert ready['type'] == 'connection/ready', ready
        host.send({'type': 'operation/request', 'id': 1,
                   'request': {'method': 'session/open', 'sessionId': 'guix-smoke'}})
        opened = host.receive()
        assert opened['result']['status'] == 'ok', opened
        host.send({'type': 'operation/request', 'id': 2, 'request': {
            'method': 'session/execute', 'sessionId': 'guix-smoke', 'request': {
                'tool_call_id': 'guix-smoke', 'enabled_tools': [],
                'source': 'text(6 * 7)', 'yield_time_ms': 1000,
                'max_output_tokens': 100}}})
        messages = []
        for _ in range(12):
            reply = host.receive()
            messages.append(reply)
            if reply['type'] == 'execute/initialResponse':
                assert reply['result']['status'] == 'ok', reply
                assert '42' in json.dumps(reply), messages
                break
        else:
            raise AssertionError(messages)
        print('Code Mode: sandbox-enabled V8 evaluated 6 * 7 = 42', flush=True)
    finally:
        host.close()

    voice_env = dict(env, GST_PLUGIN_PATH='', GST_PLUGIN_PATH_1_0='',
                     GST_PLUGIN_SYSTEM_PATH='', GST_PLUGIN_SYSTEM_PATH_1_0='',
                     GST_REGISTRY='/dev/null', GST_REGISTRY_UPDATE='no',
                     GST_REGISTRY_FORK='no')
    voice = Host([str(root / 'codex-resources/voice/bin/codex-voice-host')], '>', voice_env)
    try:
        for message, expected in (
            ({'type': 'hello', 'protocol': 1, 'buildCommit': commit}, 'ready'),
            ({'type': 'initializeRuntime'}, 'runtimeReady'),
            ({'type': 'close'}, 'closed'),
        ):
            voice.send(message)
            reply = voice.receive()
            assert reply == {'type': expected}, reply
        assert voice.process.wait(timeout=10) == 0
        print('Voice: build handshake, GStreamer/plugin initialization, shutdown passed', flush=True)
    finally:
        voice.close()
