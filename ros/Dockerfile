ARG from
FROM ${from} as deps

ARG distro=kinetic
WORKDIR /workspace

RUN  sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN mkdir ~/.gnupg

RUN apt update
COPY install_deps_${distro} install_deps
RUN apt update && ./install_deps
RUN rosdep init
RUN rosdep update

# TODO fix this, on melodic we have an issue with pyqt5 or something that prevents a clean compile :/
RUN apt install ros-${distro}-desktop-full -y

COPY fix_opencv_${distro} fix_opencv
RUN ./fix_opencv

# The below are needed if you plan to use Python 3 with ROS.
RUN pip3 install empy catkin_tools catkin_pkg rospkg setuptools --upgrade
RUN pip install setuptools --upgrade

# https://github.com/ros/catkin/issues/863

RUN mkdir src && cd src && \
    git clone https://github.com/ros-perception/image_common && \
    git clone https://github.com/ros-perception/image_transport_plugins && \
    git clone https://github.com/ros-visualization/rqt_image_view && \
    git clone https://github.com/ros-perception/vision_opencv  -b ${distro} && \
    cd .. && /bin/bash -c "source /opt/ros/${distro}/setup.bash && catkin_make -DOpenCV_DIR=/usr/local/share/OpenCV -DCMAKE_INSTALL_PREFIX=/opt/ros/${distro} -DSETUPTOOLS_DEB_LAYOUT=OFF install"
