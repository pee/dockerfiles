#
# Run slack desktop app in a container
# ORIGIN-AUTHOR:		  Jessie Frazelle <jess@linux.com>
#

FROM debian:buster
LABEL maintainer "-p <pee@erkkila.org>"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE C

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	locales \
	--no-install-recommends

RUN apt-get -y upgrade

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8


RUN apt-get update && apt-get install -y \
	gconf2 gconf-service libnotify-dev libappindicator-dev libxtst6 libnss3-dev \
	libx11-xcb-dev \
	libxss-dev \
	libasound2 \
	libxkbfile1 \
	yarn \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -o mist.deb -sSL https://github.com/ethereum/mist/releases/download/v0.9.3/Mist-linux64-0-9-3.deb
RUN dpkg -i mist.deb

RUN groupadd -g 1000 mist
RUN useradd -d /mist -m -s /bin/bash -g 1000 -u 1000 mist && echo "mist:mist" | chpasswd

USER mist

VOLUME /mist

#WORKDIR /mist
#RUN mkdir /mist/.config
#RUN mkdir /mist/.config/Mist
#RUN chown -R mist:mist /mist



#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/mist"], ['--dev']



##
