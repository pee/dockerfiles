#!/bin/bash
#
#
# XAUTH bits from here: http://wiki.ros.org/docker/Tutorials/GUI
#
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
# FIXME - might fail
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
# END

docker run --rm \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --user $(id -u):$(id -g) \
		--ipc host \
		atom:latest


#        --user="atom" \
