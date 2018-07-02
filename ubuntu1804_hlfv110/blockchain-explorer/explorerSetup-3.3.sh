#!/bin/sh
git clone https://github.com/hyperledger/blockchain-explorer.git -b release-3.3
sudo apt-get install locate postgresql -y
sudo systemctl enable postgresql
sudo service postgresql start
cd blockchain-explorer
sudo -u postgres psql -f app/persistance/postgreSQL/db/explorerpg.sql
sudo -u postgres psql -f app/persistance/postgreSQL/db/updatepg.sql
sed -i -e 's@fabric-path@'/home/vagrant'@' app/platform/fabric/config.json
# 1.0.3 causes peer dependencies to fail on node 8.10.x so stick to 1.0.1
#sed -i -e 's/\("react-d3-graph": "\)^\(1.0.1\)/\1\2/g;' client/package.json
npm install; cd client; npm install; npm run build;
cd ..
#Fix for SSL_init symbol issue? (node-grpc issue 341)
#npm rebuild --build-from-source;
#npm install -build-from-source=grpc;
