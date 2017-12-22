#!/bin/sh
#
# Originally from https://github.com//eth-playground
#

#MY_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
MY_IP=$(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')
GEN_ARGS=

if [ "$1" == "bash" ]; then
    echo "Running bash console..."
    exec /bin/bash
fi


if [[ -z $DEV_ROOT ]]; then
	echo "Unable to find DEV_ROOT"
	exit
fi


DATA_DIR=${DATA_DIR:-"/$DEV_ROOT/.ethereum"}
GENESIS=$DEV_ROOT/genesis.json
BOOTNODE=$DEV_ROOT/bootnode


# replace vars
if [[ ! -z $GEN_NONCE ]]; then
    echo "Generating genesis.nonce..."
    sed "s/\${GEN_NONCE}/$GEN_NONCE/g" -i $GENESIS
fi

echo "Generating genesis.alloc..."
sed "s/\${GEN_ALLOC}/$GEN_ALLOC/g" -i $GENESIS

echo "Generating genesis.chainid..."
sed "s/\${GEN_CHAIN_ID}/$GEN_CHAIN_ID/g" -i $GENESIS

echo "Running ethereum node with CHAIN_TYPE=$CHAIN_TYPE"
if [ "$CHAIN_TYPE" == "private" ]; then

  # empty datadir -> geth init
  echo "DATA_DIR=$DATA_DIR, contents:"
  if [ ! -d "$DATA_DIR" ] || [ -d "ls -A $DATA_DIR" ]; then
      echo "DATA_DIR '$DATA_DIR' non existant or empty. Initializing DATA_DIR..."
      geth --datadir "$DATA_DIR" init $GENESIS
  fi
  GEN_ARGS="--datadir $DATA_DIR"
  GEN_ARGS="$GEN_ARGS --nat=any"
  [[ ! -z $BOOTNODE_URL ]] && GEN_ARGS="--bootnodes=$BOOTNODE_URL $GEN_ARGS"

fi

if [ "$RUN_BOOTNODE" == "true" ]; then

    echo "Running bootnode..."
    KEY_FILE="$BOOTNODE/boot.key"
    mkdir -p $BOOTNODE
    if [ ! -f "$KEY_FILE" ]; then
       echo "(creating $KEY_FILE)"
       /usr/local/bin/bootnode --genkey="$KEY_FILE"
    fi
    [[ -z $BOOTNODE_SERVICE ]] && BOOTNODE_SERVICE=$MY_IP
    echo "Running bootnode with arguments '--nodekey=$KEY_FILE --addr $BOOTNODE_SERVICE:30301 $@'"
    exec /usr/local/bin/bootnode --nodekey="$KEY_FILE" --addr "$BOOTNODE_SERVICE:30301" "$@"

#    exec /usr/local/bin/bootnode --nodekey="$KEY_FILE" "$@"
fi

echo "Running geth with arguments $GEN_ARGS $@"
exec /usr/local/bin/geth $GEN_ARGS "$@"



##
