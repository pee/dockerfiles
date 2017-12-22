#!/bin/bash
#
# build things
#
docker-compose -f build.yml build \
	--build-arg UID=1000 \
	--build-arg GID=1000 \
	eth-main

docker-compose -f build.yml build \
	--build-arg gen_nonce="0xe1de3db4be5ddead" \
	--build-arg data_dir="/root/.ethereum" \
	--build-arg chain_type="private" \
	--build-arg run_bootnode="true" \
	--build-arg gen_chain_id="1971" \
	--build-arg bootnode_url="" \
	eth-dev
