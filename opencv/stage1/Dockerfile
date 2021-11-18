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
        cmake git wget \
        libqt5*-dev \
        qtwayland5 \
        qtbase5-dev \
        libqt5waylandcompositor5-dev \
        qttools5-dev \
        libpython3-dev \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install numpy 


COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
COPY --from=builder /usr/local/share /usr/local/share