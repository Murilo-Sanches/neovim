# Installation

## Discord Rich Presence on WSL2 (Debian) with [vyfor/cord.nvim](https://github.com/vyfor/cord.nvim):

[Wiki](https://github.com/vyfor/cord.nvim/wiki/Special-Environments#-running-inside-wsl)

```
cat >> /etc/systemd/user/discord-ipc.service <<'EOL'
[Unit]
Description=Discord IPC Relay for Cord.nvim in WSL
After=network.target

[Service]
Type=simple
ExecStartPre=/bin/rm -f /tmp/discord-ipc-0
ExecStart=/usr/bin/socat UNIX-LISTEN:/tmp/discord-ipc-0,reuseaddr,linger=0 EXEC:"/mnt/c/tools/npiperelay.exe -ep -s //./pipe/discord-ipc-0",nofork
Restart=always
WorkingDirectory=/tmp

[Install]
WantedBy=default.target
EOL
```

```
systemctl --user daemon-reload
systemctl --user enable discord-ipc
systemctl --user start discord-ipc
systemctl --user status discord-ipc
```

```
if ! pidof socat > /dev/null 2>&1; then
    [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0
    nohup socat UNIX-LISTEN:/tmp/discord-ipc-0,fork \
        EXEC:"/mnt/c/tools/npiperelay.exe //./pipe/discord-ipc-0" >/dev/null 2>&1 &
fi
```
