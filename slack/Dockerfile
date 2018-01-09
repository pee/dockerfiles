# Run slack desktop app in a container
# ORIGIN-AUTHOR:		  Jessie Frazelle <jess@linux.com>
#

FROM debian:buster
LABEL maintainer "-p <pee@erkkila.org>"

ENV TERM vt100

RUN apt-get update -y

RUN apt-get install \
	--no-install-recommends \
	-y \
	apt-utils \
	locales \
	dialog \
	libterm-readline-gnu-perl

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

RUN	locale-gen en_US.UTF-8
RUN	/usr/sbin/update-locale LANG=en_US.UTF-8

RUN apt-get upgrade -y

RUN apt autoremove -y

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Add the slack debian repo
RUN curl -sSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slacktechnologies_slack.list

RUN apt-get update && apt-get -y install \
	libx11-xcb1 \
	libasound2 \
	libxkbfile1 \
	slack-desktop \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*


RUN groupadd -g 1000 slack
RUN useradd -d /slack -m -s /bin/bash -g 1000 -u 1000 slack && echo "slack:slack" | chpasswd && adduser slack sudo
WORKDIR /slack

RUN chown -R slack:slack /slack

USER slack


ENTRYPOINT ["/usr/lib/slack/slack"]



##
