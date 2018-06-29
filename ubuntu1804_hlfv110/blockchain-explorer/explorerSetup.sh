#!/bin/sh
git clone https://github.com/hyperledger/blockchain-explorer.git -b release-3.1
sudo apt-get install locate postgresql -y
sudo systemctl enable postgresql
sudo service postgresql start
cd blockchain-explorer
sudo -u postgres psql -f app/db/explorerpg.sql
sudo -u postgres psql -f app/db/updatepg.sql
sed -i -e 's@fabric-path@'/home/vagrant'@' config.json
# 1.0.3 causes peer dependencies to fail so stick to 1.0.1
sed -i -e 's/\("react-d3-graph": "\)^\(1.0.1\)/\1\2/g;' client/package.json
npm install; cd client; npm install; npm run build;
cd ..
#Fix for SSL_init symbol issue?
#npm rebuild --build-from-source;

