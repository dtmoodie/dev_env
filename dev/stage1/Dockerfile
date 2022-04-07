FROM dtmoodie:dev_builder-2004 as deps

FROM dtmoodie:ros-2004

COPY --from=deps /usr/local/include /usr/local/include
COPY --from=deps /usr/local/lib /usr/local/lib
COPY --from=deps /usr/local/share /usr/local/share
COPY --from=deps /usr/local/bin /usr/local/bin
COPY --from=deps /workspace/darknet /workspace/darknet

ARG user=dan
ARG uid=1000
ARG gid=1000
ARG useremail=dtmoodie@gmail.com
ARG username=dan
ARG uid=1000
ARG work_dir=/home/${user}

RUN dpkg --add-architecture i386
RUN apt update
RUN apt install -y \
    build-essential \
    gdb \
    cmake \
    strace \
    libglvnd-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libglvnd-dev:i386 \
    libgl1-mesa-dev:i386 \
    libegl1-mesa-dev:i386 \
    byobu \
    openssh-server \
    vim \
    valgrind \
    nsight-systems \
    clang-format \
    clangd


RUN echo "Port 25" >> /etc/ssh/sshd_config

####################################################
# setup a non-root user, this is important for file permissions if you volume mount code 
# as well as running xsessions inside the container
ENV USERNAME ${user}
ENV UID ${uid}
ENV GID ${gid}
RUN groupadd -g ${GID} "${USERNAME}" &&\
    useradd -ms /bin/bash -u ${UID} -g "${USERNAME}" "${USERNAME}" &&\
    echo "$USERNAME:$USERNAME" | chpasswd &&\
    usermod -aG sudo $USERNAME &&\
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME &&\
    chmod 0440 /etc/sudoers.d/$USERNAME
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ADD entrypoint.sh /tmp/entrypoint.sh
RUN chmod 777 /tmp/entrypoint.sh
USER $USERNAME
ENTRYPOINT ["/tmp/entrypoint.sh"]

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute,display
# resolves conflict between system install of mpi with conda install, fixes torch import
ENV LD_LIBRARY_PATH=/opt/hpcx/ompi/lib:$LD_LIBRARY_PATH
WORKDIR /home/$user/code
RUN python3 -m pip install pytorch_lightning timm 

COPY nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb
RUN sudo apt-get install -y ./nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb
