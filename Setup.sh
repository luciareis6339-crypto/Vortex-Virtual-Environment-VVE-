#!/bin/bash
DURATION=1800
echo "🚀 Iniciando Vortex VE - Sessão de 30 min"
sudo apt update -y && sudo apt install -y xfce4 xfce4-goodies novnc python3-websockify wget > /dev/null 2>&1
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb > /dev/null 2>&1
export DISPLAY=:1
Xvfb :1 -screen 0 800x600x16 &
xfce4-session &
websockify --web /usr/share/novnc/ 6080 localhost:5901 &
vncserver :1 -geometry 800x600 -depth 16 > /dev/null 2>&1
echo "✅ Clique no link .trycloudflare.com abaixo:"
(sleep $DURATION && sudo kill -9 -1) &
cloudflared tunnel --url http://localhost:6080
