ARG BASE_IMAGE
FROM opencv_builder AS builder
ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer-plugins-good1.0-dev \
        libgstreamer1.0-dev \
        libgstreamer-plugins-bad1.0-dev \
        libgstreamer-opencv1.0-0 \
        libgstreamer-gl1.0-0 \
        gstreamer1.0-tools \
        cmake git wget \
        libqt5*-dev \
        qtwayland5 \
        qtbase5-dev \
        libqt5waylandcompositor5-dev \
        qttools5-dev \
        libpython3-dev \
        libopenjp2-7-dev \
        libceres-dev \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# the nvidia base image comes with opencv built in which mucks things up with our cuda build
#RUN rm /usr/lib/x86_64-linux-gnu/libopencv_*
#RUN rm /usr/lib/x86_64-linux-gnu/pkgconfig/opencv.pc
#RUN rm -rf /usr/share/OpenCV

RUN python3 -m pip install numpy 


COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
COPY --from=builder /usr/local/share /usr/local/share
COPY --from=builder /usr/local/lib/python3.8/site-packages/cv2 /opt/conda/lib/python3.8/site-packages/cv2
