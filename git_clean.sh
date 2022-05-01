# Revert any local changes to ServerSnippets
chmod -R 777 /root/ServerSnippets
cd /root/ServerSnippets
git checkout .
git clean -fxd :/