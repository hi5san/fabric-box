#!/bin/sh
echo Running byfn..
(cd fabric-samples/first-network; echo Y | ./byfn.sh down; echo Y | ./byfn.sh up)
echo Starting explorer in 5 seconds...
sleep 5
cd blockchain-explorer; ./start.sh;
echo Explorer started.  Begin tailing console log in 5 seconds...
sleep 5
tail -f -n +1 logs/console/log.* &
