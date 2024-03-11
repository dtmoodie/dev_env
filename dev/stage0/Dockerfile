FROM opencv

WORKDIR /workspace

COPY cereal cereal
COPY pybind11 pybind11
COPY dlib dlib
COPY darknet darknet
COPY colmap colmap
#COPY ct ct
#COPY ctext ctext
#COPY minitensor minitensor


WORKDIR /workspace/cereal/build
RUN cmake .. -DJUST_INSTALL_CEREAL=ON && \
    make && \
    make install

WORKDIR /workspace/pybind11/build
RUN cmake .. && \
    make -j24 && \
    make install

RUN apt-get update && \
    apt-get install -y libopenblas-dev libeigen3-dev && \
    rm -rf /var/lib/apt/lists/


WORKDIR /workspace/dlib/build
RUN cmake .. \
        -DDLIB_USE_MKL_FFT=OFF \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON && \
    make -j24 && \
    make install

WORKDIR /workspace/darknet
RUN make -j24 GPU=1 CUDNN=1 CUDNN_HALF=1 LIBSO=1


RUN apt-get update && apt-get install -y\
    git \
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

WORKDIR /workspace/colmap/build
RUN cmake .. \
      -DCMAKE_CUDA_ARCHITECTURES=80
RUN make -j24
