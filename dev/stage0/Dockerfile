FROM dtmoodie:ros-2004

WORKDIR /workspace

COPY cereal cereal
COPY pybind11 pybind11
COPY dlib dlib
COPY ct ct
COPY ctext ctext
COPY minitensor minitensor


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

WORKDIR /workspace/ct/build
RUN cmake .. && \
    make -j24 && \
    make install

WORKDIR /workspace/minitensor/build
RUN cmake .. && \
    make -j24 && \
    make install

WORKDIR /workspace/ctext/build
RUN cmake .. && \
    make && \
    make install