# Assum root
cd /root

# Install Basic Environment
./install_basic.sh
./install_net_core_dev_env.sh

# Start tmux session
tmux new -s background
# ctrl+b %: Split
# ctrl+b d: Detach
# ctrl+b o: Swap pane
# Scroll: ctrl+b then [ then usual navigation keys (arros and page up/down), ESC to exit.

# Initialize repo
git clone https://github.com/chaojian-zhang/ServerSnippets.git
chmod -R 777 /root/ServerSnippets

# SSL
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot certonly --standalone
# Running HTTPS requires NGINX for easier certificate management, otherwise configure Kestrel to use HTTPS is hard.