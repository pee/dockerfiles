# DESCRIPTION:	  Create the atom editor in a container
# ORIGIN-AUTHOR:		  Jessie Frazelle <jess@linux.com>
# COMMENTS:
#	This file describes how to build the atom editor
#	in a container with all dependencies installed.
#	Note: atom is not a node-webkit app,
#	found this out a little too late into this example
#	it uses electron(https://github.com/atom/electron)
#	Tested on Debian Jessie.
#
#

# Base docker image
FROM debian:buster
LABEL maintainer "-p <pee@erkkila.org>"

# Install dependencies
RUN apt-get update && apt-get install -y \
	git \
	gconf2 \
	gconf-service \
	gvfs-bin \
	libasound2 \
	libcap2 \
	libgconf-2-4 \
	libgnome-keyring-dev \
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxkbfile1 \
	libxss1 \
	libxtst6 \
	libx11-xcb-dev \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV ATOM_VERSION 1.22.1

# download the source
RUN buildDeps=' \
		ca-certificates \
		curl \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
	&& dpkg -i /tmp/atom-amd64.deb \
	&& rm -rf /tmp/*.deb \
	&& apt-get purge -y --auto-remove $buildDeps

RUN groupadd -g 1000 atom
RUN useradd -d /atom -m -s /bin/bash -g 1000 -u 1000 atom && echo "atom:atom" | chpasswd && adduser atom sudo
WORKDIR /atom

RUN chown -R atom:atom /atom

USER atom


# Autorun atom
ENTRYPOINT [ "atom", "--foreground" ]



##
