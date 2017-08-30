FROM ubuntu:14.04
MAINTAINER Waseem Khan <waseem.khan@rutgers.edu>

# Setup basic requirements and PCL 1.6
RUN apt-get update && apt-get install -y software-properties-common \
  && add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl \
  && apt-get update \
  && apt-get install -y \
  cmake \
  git \
  libpcl-all \
  python \
  unzip \
  vim \
  vim-gnome \
  wget

# Setup PCL 1.8
RUN cd /opt \
  && git clone https://github.com/PointCloudLibrary/pcl pcl-trunk \
  && cd pcl-trunk && mkdir build && cd build \
  && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. \ 
  && make -j2
# RUN make install -j2
RUN cd /usr/local/bin \
  && ln -sf /opt/pcl-trunk/build/bin/pcl_ply2pcd pcl1.8_ply2pcd \ 
  && ln -sf /opt/pcl-trunk/build/bin/pcl_pcd2ply pcl1.8_pcd2ply \
  && ln -sf /opt/pcl-trunk/build/bin/pcl_vtk2pcd pcl1.8_vtk2pcd \
  && ln -sf /opt/pcl-trunk/build/bin/pcl_pcd2vtk pcl1.8_pcd2vtk \

# Setup GoICP
RUN cd /opt \
  && wget http://jlyang.org/go-icp/Go-ICP_V1.3.zip \
  && unzip Go-ICP_V1.3.zip \
  && mv GoICP_V1.3/ go-icp && rm Go-ICP_V1.3.zip \
  && cd go-icp/src/ \
  && mkdir build && cd build \
  && cmake .. \
  && make -j2 \
  && cp GoICP /usr/local/bin/

# Clone go-icp-script and setup
RUN cd /root \
  && git clone https://github.com/UCSD-E4E/maya-archaeology \
  && cd maya-archaeology/go-icp-script/ \
  && mkdir build && cd build \
  && cmake .. \
  && make -j2

RUN mkdir /models
