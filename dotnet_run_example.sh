# Formal server setup
# sudo mkdir /var/www/
# sudo mkdir /var/www/
# sudo chown -R dries:www-data /var/www/

# Quick setup
sudo mkdir /root/risk
# Send the files over to /root/risk
chmod -R 777 /root/risk

tmux new -s background
cd /root/risk/ # Necessary for correct content root
dotnet /root/risk/PortfolioBuilder.dll --urls https://0.0.0.0:80
# ctrl+b %: Split
# ctrl+b d: Detach
# ctrl+b o: Swap pane
# Scroll: ctrl+b then [ then usual navigation keys (arros and page up/down), ESC to exit.
tmux a -t background