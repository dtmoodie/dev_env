FROM dtmoodie:ros-2004

WORKDIR /workspace

COPY cereal cereal
COPY pybind11 pybind11
COPY dlib dlib

WORKDIR /workspace/cereal/build
RUN cmake .. -DJUST_INSTALL_CEREAL=ON && \
    make && \
    make install

WORKDIR /workspace/pybind11/build
RUN cmake .. && \
    make && \
    make install

RUN apt-get update && \
    apt-get install -y libopenblas-dev libeigen3-dev && \
    rm -rf /var/lib/apt/lists/

WORKDIR /workspace/dlib/build
RUN cmake .. && \
    make && \
    make install

