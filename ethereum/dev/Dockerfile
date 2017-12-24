##
# 
# Dev bits
#
##########
FROM pee/eth-main:latest

ARG gen_nonce
ARG dev_root="/ethdev"
ARG data_dir="${dev_root}/.ethereum"
ARG chain_type
ARG run_bootnode
ARG gen_chain_id
ARG bootnode_url

ENV DEV_ROOT=${dev_root}
ENV GEN_NONCE=${gen_nonce}
ENV DATA_DIR=${data_dir}
ENV CHAIN_TYPE=${chain_type}
ENV RUN_BOOTNODE=${run_bootnode}
ENV GEN_CHAIN_ID=${gen_chain_id}
ENV BOOTNODE_URL=${bootnode_url}

# like ethereum/client-go
#EXPOSE 30303
#EXPOSE 8545

# bootnode port
#EXPOSE 30301
#EXPOSE 30301/udp


# create /opt
USER root
RUN mkdir -p ${dev_root}/bin

ADD bin/* ${dev_root}/bin/
ADD genesis.json ${dev_root}/

RUN chown -R eth:eth ${dev_root}
RUN chmod +x ${dev_root}/bin/*.sh

RUN mkdir /boot
RUN chown eth:eth /boot
VOLUME /boot

USER eth
WORKDIR /devnet


## FIXME: does not use dev_root
ENTRYPOINT ["/ethdev/bin/startgeth.sh"]




