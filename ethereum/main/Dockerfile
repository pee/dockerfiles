##
# 
# Build Geth in a stock Go builder container
#
##
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git


## Grab and build ethereum go client (geth)
RUN mkdir /git
WORKDIR /git
RUN git clone https://github.com/ethereum/go-ethereum
RUN cd go-ethereum && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates shadow bash

COPY --from=builder /git/go-ethereum/build/bin/* /usr/local/bin/

EXPOSE 8545 8546 30303 30303/udp 30304/udp

# uid
ARG UID=1000
ENV uid=$UID

# gid
ARG GID=1000
ENV gid=$GID

RUN groupadd -g $gid eth
RUN useradd -d /geth -m -s /bin/bash -u ${uid} -g ${gid} eth && echo "eth:eth" | chpasswd

RUN chown -R ${uid}:${gid} /geth

USER eth

WORKDIR /geth

ENTRYPOINT ["geth"]

