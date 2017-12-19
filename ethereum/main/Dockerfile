##
# 
# Build Geth in a stock Go builder container
#
##
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

#ADD . /go-ethereum
RUN git clone https://github.com/ethereum/go-ethereum
RUN cd go-ethereum && make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates shadow bash
COPY --from=builder /go/go-ethereum/build/bin/* /usr/local/bin/

EXPOSE 8545 8546 30303 30303/udp 30304/udp

RUN groupadd -g 1000 eth
RUN useradd -d /root -m -s /bin/bash -g 1000 -u 1000 eth && echo "eth:eth" | chpasswd

RUN chown -R 1000:1000 /root

USER eth

WORKDIR /root

ENTRYPOINT ["geth"]

