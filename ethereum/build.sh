#!/bin/bash
#
# build things
#
docker-compose build \
	--build-arg UID=1000 \
	--build-arg GID=1000 \
	eth-main

docker-compose build \
	--build-arg gen_nonce="0xe1de3db4be5ddead" \
	--build-arg dev_root="/ethdev" \
	--build-arg data_dir="/ethdev/.ethereum" \
	--build-arg chain_type="private" \
	--build-arg run_bootnode="false" \
	--build-arg gen_chain_id="1971" \
	--build-arg bootnode_url="" \
	eth-dev

docker-compose build \
	bootnode

docker-compose build \
	rpcnode

docker-compose build \
	worknode

docker-compose build \
	minernode
