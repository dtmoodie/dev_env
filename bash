XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# https://medium.com/@benjamin.botto/opengl-and-cuda-applications-in-docker-af0eece000f1

docker run --gpus=all -it --rm \
 --env="DISPLAY" \
 --env="QT_X11_NO_MITSHM=1" \
 --env="XAUTHORITY=${XAUTH}" \
 --env=TERM=xterm-256color \
 --env="PYTHONPATH=/opt/ros/noetic/lib/python3.8/site-packages:/opt/ros/noetic/lib/python3/dist-packages" \
 --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
 --volume="/home/dan/code:/home/dan/code" \
 --volume="/data:/data" \
 --volume=/dev:/dev:rw \
 --volume=/media/dan:/media/dan \
 --network host \
 --privileged \
 --shm-size=80G \
 --security-opt seccomp=unconfined \
 --name ${2:-$1} \
 dtmoodie:$1 /bin/bash
