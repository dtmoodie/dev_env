FROM dtmoodie:dev_builder-2004 as deps

FROM opencv

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
RUN apt-get update && \
    apt install -y \
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
    clangd \
    sudo \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev


RUN echo "Port 25" >> /etc/ssh/sshd_config

####################################################
# setup a non-root user, this is important for file permissions if you volume mount code 
# as well as running xsessions inside the container
ENV USERNAME ${user}
ENV UID ${uid}
ENV GID ${gid}
RUN mkdir -p /etc/sudoers.d
RUN touch /etc/sudoers.d/$USERNAME
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
ENV PYTHONPATH=$PYTHONPATH:/opt/ros/noetic/lib/python3/dist-packages

WORKDIR /home/$user/code
RUN python3 -m pip install pytorch_lightning timm 

COPY nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb
RUN sudo apt-get install -y ./nsight-systems-2022.1.1_2022.1.1.61-1_amd64.deb

# This enables matplotlib to make a pop up window for gdb-imagewatch
RUN pip install PyQt5


# these are for colmap
RUN sudo apt-get install -y \
    git \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev


COPY requirements.txt requirements.txt
RUN sudo python3 -m pip install -r requirements.txt
COPY requirements_comfy.txt requirements.txt
RUN sudo python3 -m pip install -r requirements.txt

# these are for emernerf
RUN pip install git+https://github.com/KAIR-BAIR/nerfacc.git
RUN TCNN_CUDA_ARCHITECTURES=86 pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
RUN pip install nuscenes-devkit
RUN pip install numpy==1.24.1
RUN pip install triton

# using version 0.0.21 because main current crashes when compilg flash attention due to a segmentation fault from the compiler
RUN MAX_JOBS=2 pip install -v -U git+https://github.com/facebookresearch/xformers.git@v0.0.21#egg=xformers
