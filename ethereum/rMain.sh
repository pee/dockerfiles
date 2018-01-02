#!/bin/bash
##
##
##
ETHERBASE="0x24cee16eb03635609c857f500eb6418aa773cb88"
#
docker stop eth-main

#
docker run -d --name eth-main -v /s/ethereum:/geth \
           -p 8545:8545 -p 30303:30303 \
           --user $(id -u):$(id -g) \
		   --restart on-failure:10 \
           pee/eth-main:latest \
		   --rpc --rpcaddr 0.0.0.0 \
		   --etherbase ${ETHERBASE} \
		   --metrics



