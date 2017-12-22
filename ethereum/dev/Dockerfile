##
# 
# Build Geth in a stock Go builder container
#
##
FROM pee/eth-main:latest

ARG gen_nonce
ARG data_dir
ARG chain_type
ARG run_bootnode
ARG gen_chain_id
ARG bootnode_url

ENV GEN_NONCE=${gen_nonce}
ENV DATA_DIR=${data_dir}
ENV CHAIN_TYPE=${chain_type}
ENV RUN_BOOTNODE=${run_bootnode}
ENV GEN_CHAIN_ID=${gen_chain_id}
ENV BOOTNODE_URL=${bootnode_url}


WORKDIR /opt

# like ethereum/client-go
EXPOSE 30303
EXPOSE 8545

# bootnode port
EXPOSE 30301
EXPOSE 30301/udp

# ADD src/* /opt/
# RUN chmod +x /opt/*.sh

#CMD ["/opt/startgeth.sh"]
ENTRYPOINT ["/opt/startgeth.sh"]




