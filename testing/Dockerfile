FROM ubuntu:20.04
MAINTAINER timokoch@uio.no
RUN rm -f /etc/apt/apt.conf.d/docker-gzip-indexes \
  && rm -rf /var/lib/apt/lists/*

RUN export DEBIAN_FRONTEND=noninteractive; \
  apt-get update \
  && apt-get dist-upgrade --no-install-recommends --yes \
  && apt-get install --no-install-recommends --yes \
  ca-certificates \
  ssh \
  vim \
  python3-dev \
  python3-pip \
  libffi-dev \
  git \
  pkg-config \
  build-essential \
  gfortran \
  cmake \
  zlib1g-dev \
  ninja-build \
  wget \
  clang \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# add CI user
RUN adduser --disabled-password --home /dumuxci --uid 50000 dumuxci

# install Python dependencies of the test suite
RUN pip3 install --upgrade pip numpy black pylint flake8

# set versions
ARG DUNE_BRANCH

# add dune core sources
RUN mkdir -p /dune/modules
RUN cd /dune/modules && \
    git clone -b $DUNE_BRANCH --depth 1 https://gitlab.dune-project.org/core/dune-common.git && \
    git clone -b $DUNE_BRANCH --depth 1 https://gitlab.dune-project.org/core/dune-geometry.git && \
    git clone -b $DUNE_BRANCH --depth 1 https://gitlab.dune-project.org/core/dune-grid.git && \
    cd

RUN mkdir -p /dune/bin
RUN ln -s /dune/modules/dune-common/bin/dunecontrol /dune/bin/dunecontrol
RUN ln -s /dune/modules/dune-common/bin/dune-ctest /dune/bin/dune-ctest
ENV PATH=/dune/bin:$PATH
ENV DUNE_CONTROL_PATH=.:/dune/modules

# add the dune control option files
RUN mkdir -p /opts
ADD gcc.minimal.opts /opts/gcc.opts

# run dunecontrol with specified opts file
ARG OPTS_FILE
ARG DUMUX_BRANCH=master
ENV DUNE_OPTS_FILE=/opts/gcc.opts

RUN cd /dune/modules && \
    dunecontrol --opts=$DUNE_OPTS_FILE configure && \
    dunecontrol --opts=$DUNE_OPTS_FILE make -j8 && \
    cd

# maybe clone dumux for downstream modules
ARG CLONE_DUMUX
RUN if [ ! -z "$CLONE_DUMUX" ]; \
    then \
      cd /dune/modules && \
      git clone -b ${DUMUX_BRANCH} https://git.iws.uni-stuttgart.de/dumux-repositories/dumux.git && \
      cd; \
    fi

