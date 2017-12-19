#!/bin/bash
##
##
##

#
docker stop eth-main

#
docker run -d --name eth-main -v /s/ethereum:/root \
           -p 8545:8545 -p 30303:30303 \
           --user $(id -u):$(id -g) \
		   --restart on-failure:10 \
           pee/eth-main:latest --rpc \
		   --rpcaddr 0.0.0.0 


