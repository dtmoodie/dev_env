ARG BASE_IMAGE
FROM opencv_builder AS builder
ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive

RUN rm -rf /usr/local/lib/libopencv* && \
  rm -rf /usr/local/include/opencv4 && \
  rm -rf /usr/local/lib/cmake/opencv4 && \
  rm -rf /usr/local/share/opencv4 && \
  rm -rf /usr/local/lib/python3.8/dist-packages/opencv-* \
  rm -rf /usr/local/lib/python3.8/dist-packages/cv2 \
  rm -rf /usr/local/lib/python3.8/site-packages/cv2

RUN python3 -c "import torch"

RUN apt-get update && \
  apt-get install -y \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-good1.0-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  libgstreamer-gl1.0-0 \
  gstreamer1.0-libav \
  gstreamer1.0-tools \
  cmake git wget \
  libqt5*-dev \
  qtwayland5 \
  qtbase5-dev \
  libqt5waylandcompositor5-dev \
  qttools5-dev \
  libopenjp2-7-dev \
  libceres-dev \
  libboost-all-dev \
  libeigen3-dev

# The above apt install ends up installing a different version of ucs that breaks torch :/
# so we explicitly override and use the build installed here
ENV LD_LIBRARY_PATH=/opt/hpcx/ucx/lib:/opt/hpcx/ompi/lib/:$LD_LIBRARY_PATH
# This is just a check to make sure torch still loads, it validates that the above line is 
# working as intended
RUN python3 -c "import torch"
# the nvidia base image comes with opencv built in which mucks things up with our cuda build
#RUN rm /usr/lib/x86_64-linux-gnu/libopencv_*
#RUN rm /usr/lib/x86_64-linux-gnu/pkgconfig/opencv.pc
#RUN rm -rf /usr/share/OpenCV

RUN python3 -m pip install numpy 


COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
COPY --from=builder /usr/local/share /usr/local/share
#COPY --from=builder /usr/local/lib/python3.8/site-packages/cv2 /usr/local/lib/python3.8/site-packages/cv2
COPY --from=builder /usr/local/lib/python3.10/dist-packages/cv2 /usr/local/lib/python3.8/site-packages/cv2

RUN python3 -c "import torch"
