#!/bin/bash

#docker restart --name ethereum-node -v /s/ethereum:/root \
#           -p 8545:8545 -p 30303:30303 \
#           ethereum/client-go --fast --cache=4096

#docker run -d --name ethereum-node -v /s/ethereum:/root \
#           -p 8545:8545 -p 30303:30303 \
#           ethereum/client-go --cache=4096 --rpc \
#		   -mine --minerthreads 2 --etherbase 0

docker stop ethereum_main
docker rm  ethereum_main
docker run -d --name ethereum_main -v /s/ethereum:/root \
           -p 8545:8545 -p 30303:30303 \
           --user $(id -u):$(id -g) \
		   --restart on-failure:10 \
           ethereum/go-ethereum --rpc \
		   --rpcaddr 0.0.0.0 \
		   --metrics \
		   --etherbase 24cee16eb03635609c857f500eb6418aa773cb88
#		   -mine --minerthreads 1 --etherbase 24cee16eb03635609c857f500eb6418aa773cb88


