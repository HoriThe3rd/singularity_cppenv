#!/bin/bash
# To installing opencv library in WSL environment.
# You have to execute this script with root permission.

apt update
apt upgrade -y

apt install -y build-essential \
    cmake \
    doxygen \
    libgtk-3-dev \
    python-dev \
    python-numpy \
    ffmpeg \
    libwebp-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libdc1394-22 \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    git \
    wget \
    libgoogle-glog-dev \
    libgflags-dev

# Working directory: /usr/local/src/opencv
mkdir /usr/local/src/opencv
cd /usr/local/src/opencv
wget -O ./opencv-3.4.3.tar.gz https://github.com/opencv/opencv/archive/3.4.3.tar.gz
echo "Extracting opencv..."
tar -xzf ./opencv-3.4.3.tar.gz
rm ./opencv-3.4.3.tar.gz
echo "done."

wget -O ./opencv_contrib-3.4.3.tar.gz https://github.com/opencv/opencv_contrib/archive/3.4.3.tar.gz
echo "Extracting opencv_contrib..."
tar -xzf ./opencv_contrib-3.4.3.tar.gz
rm ./opencv_contrib-3.4.3.tar.gz
echo "done."

# For eigen
mkdir /usr/local/src/opencv/eigen
cd /usr/local/src/opencv/eigen
wget -O ./3.3.5.tar.gz http://bitbucket.org/eigen/eigen/get/3.3.5.tar.gz
mkdir ./eigen3.3.5
echo "Extracting Eigen..."
tar -xzf ./3.3.5.tar.gz -C ./eigen3.3.5 --strip-components 1
rm ./3.3.5.tar.gz
echo "done."

# Build and install
mkdir /usr/local/src/opencv/opencv-3.4.3/build
cd /usr/local/src/opencv/opencv-3.4.3/build
cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.3/modules/ \
    -DWITH_TBB=ON \
    -DWITH_FFMPEG=ON \
    -DWITH_EIGEN=ON \
    -DEIGEN_INCLUDE_PATH=../../eigen/eigen3.3.5/ \
    ..
make -j2 && make install && ldconfig
