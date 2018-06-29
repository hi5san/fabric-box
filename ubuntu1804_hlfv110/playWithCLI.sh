#!/bin/sh
echo === Be sure to have byfn up and running.. ===
echo == Running peer version...
docker exec cli peer version
sleep 3
echo == Running peer node status...
docker exec cli peer node status
sleep 3
echo == Running peer query for a and b..
docker exec cli peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
docker exec cli peer chaincode query -C mychannel -n mycc -c '{"Args":["query","b"]}'
sleep 3
echo == Running peer invoke transfer a b 25..
docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -c '{"Args":["invoke","a","b","25"]}'
sleep 3
echo == Running peer query again for a and b..
docker exec cli peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
docker exec cli peer chaincode query -C mychannel -n mycc -c '{"Args":["query","b"]}'
