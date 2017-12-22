##
# 
# Dev bits
#
##########
## builder
##
FROM golang:1.9-alpine as builder

RUN apk add --no-cache git

WORKDIR /git
RUN git clone https://github.com/pee/eth-playground
RUN pwd && ls -al

##
## end builder
##

FROM pee/eth-main:latest

ARG gen_nonce
ARG data_dir="/ethdev/.ethereum"
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


# create /opt
USER root
RUN mkdir /opt

COPY --from=builder /git/eth-playground/src/* /opt/

RUN chown -R eth:eth /opt
RUN chmod +x /opt/*.sh

RUN mkdir /ethdev
RUN chown eth:eth /ethdev

USER eth
WORKDIR /opt

# like ethereum/client-go
EXPOSE 30303
EXPOSE 8545

# bootnode port
EXPOSE 30301
EXPOSE 30301/udp

ENTRYPOINT ["/opt/startgeth.sh"]




