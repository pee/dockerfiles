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

docker run --rm  -it \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
		--volume=/etc/localtime:/etc/localtime:ro \
		--volume="${HOME}/.slack:/slack/.config/Slack" \
		--device /dev/snd \
		--device /dev/dri \
		--device /dev/video0 \
		--group-add audio \
		--group-add video \
        --user $(id -u):$(id -g) \
		--ipc host \
		--name slack \
		slack:latest "$@"



#
#
