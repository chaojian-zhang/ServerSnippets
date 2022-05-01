# Add those folders to VS Code Workspace
# /root
# /var/www
# /etc/nginx
# /var/log/nginx

# Assum root
cd /root

# Install Basic Environment
./install_basic.sh
./install_net_core_dev_env.sh

# Start tmux session
tmux new -s background
tmux a -t background
# ctrl+b %: Split
# ctrl+b d: Detach
# ctrl+b o: Swap pane
# Scroll: ctrl+b then [ then usual navigation keys (arros and page up/down), ESC to exit.

# Initialize repo
git clone https://github.com/chaojian-zhang/ServerSnippets.git
chmod -R 777 /root/ServerSnippets
# Clean up
# ./git_clean.sh