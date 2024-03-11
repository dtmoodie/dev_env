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
    python3-pip \
    libopenjp2-7-dev \
    libceres-dev

RUN python3 -m pip install numpy 

# delete existing opencv install from ros
RUN rm -rf /usr/local/lib/libopencv* && \
  rm -rf /usr/local/include/opencv4 && \
  rm -rf /usr/local/lib/cmake/opencv4 && \
  rm -rf /usr/local/share/opencv4 && \
  rm -rf /usr/local/lib/python3.8/dist-packages/opencv-* \
  rm -rf /usr/local/lib/python3.8/dist-packages/cv2 \
  rm -rf /usr/local/lib/python3.8/site-packages/cv2

RUN cmake .. \
    -DBUILD_opencv_cudacodec=OFF \
    -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -DWITH_CUDA=ON \
    -DWITH_CUFFT=ON \
    -DWITH_OPENGL=ON \
    -DWITH_QT=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_opencv_xfeatures2d=OFF \
    -DOpenGL_GL_PREFERENCE=GLVND \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DBUILD_OPENJPEG=ON \
    -DBUILD_JPEG=ON \
    -DBUILD_WEBP=ON \
    -DBUILD_ZLIB=ON
    #-DPYTHON3_INCLUDE_PATH=/opt/conda/include/python3.8 \
    #-DPYTHON3_NUMPY_INCLUDE_DIRS=/opt/conda/lib/python3.8/site-packages/numpy/core/include \
    #-DPYTHON3_EXECUTABLE=/opt/conda/bin/python3

RUN make -j24 \
    && make install

RUN cmake .. \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_DEBUG_POSTFIX=d \
    && make -j24 \
    && make install
