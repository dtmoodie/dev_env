ARG BASE_IMAGE
FROM $BASE_IMAGE

WORKDIR /workspace
COPY opencv opencv
COPY opencv_contrib opencv_contrib

WORKDIR /workspace/opencv/build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
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
    python3-pip

RUN python3 -m pip install numpy 

RUN cmake .. \
    -DBUILD_opencv_cudacodec=OFF \
    -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -DWITH_CUDA=ON \
    -DWITH_CUBLAS=ON \
    -DWITH_CUFFT=ON \
    -DWITH_OPENGL=ON \
    -DWITH_QT=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_opencv_xfeatures2d=OFF \
    && make -j24 \
    && make install


