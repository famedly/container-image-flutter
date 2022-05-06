FROM debian:bullseye-slim

LABEL maintainer="info@famedly.com"

ARG flutter_version
ARG channel

ENV PATH /home/famedly/flutter/bin:$PATH

# Get openssl, lcov and gcc
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        sudo \
        locales \
        openssl \
        ca-certificates \
        git \
        openssh-client \
        lcov \
        curl \
        unzip \
        xz-utils \
        clang \
        cmake \
        ninja-build \
        pkg-config \
        libgtk-3-dev \
        libblkid-dev \ 
        liblzma-dev \
        libsecret-1-dev \
        libjsoncpp-dev \
    && rm -rf /var/lib/apt/lists/*

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN groupadd --gid 3434 famedly \
    && useradd --uid 3434 --gid famedly --groups sudo --shell /bin/bash --create-home famedly \
    && (echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers)

# Install flutter
RUN cd /home/famedly && curl "https://storage.googleapis.com/flutter_infra_release/releases/${channel}/linux/flutter_linux_${flutter_version}-${channel}.tar.xz" | tar xJ && chown -R famedly:famedly flutter && flutter doctor && flutter config --no-analytics

# Make sure we have UTF-8
RUN echo "LC_ALL=en_US.UTF-8" > /etc/environment \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && locale-gen en_US.UTF-8

USER famedly
ENV HOME /home/famedly
ENV PATH /home/famedly/.local/bin:/home/famedly/bin:${PATH}
