#!/bin/sh
git clone -b master https://github.com/hyperledger/fabric-samples.git
cd fabric-samples
git checkout v1.1.0
git clone https://github.com/IBM-Blockchain/marbles.git --single-branch --branch v5.0
cd marbles; npm install; sudo npm install gulp -g; cd ..
curl -sSL https://goo.gl/PKqygD | bash -s 1.1.0
