FROM ubuntu:jammy

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
        python3 \
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
        libolm3 \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Add coverage script
RUN curl -o /bin/lcov_cobertura.py https://raw.githubusercontent.com/eriwen/lcov-to-cobertura-xml/master/lcov_cobertura/lcov_cobertura.py && sed 's/env python/env python3/' -i /bin/lcov_cobertura.py && chmod +x /bin/lcov_cobertura.py

RUN groupadd --gid 3434 famedly \
    && useradd --uid 3434 --gid famedly --groups sudo --shell /bin/bash --create-home famedly \
    && (echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers)

# Make sure we have UTF-8
RUN echo "LC_ALL=en_US.UTF-8" > /etc/environment \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && locale-gen en_US.UTF-8

USER famedly
ENV HOME /home/famedly
ENV PATH /home/famedly/.local/bin:/home/famedly/bin:${PATH}

# Install flutter
RUN cd /home/famedly && ( git clone --depth 1 https://github.com/flutter/flutter.git -b ${flutter_version} || git clone --depth 1 https://github.via-ipv6.com/flutter/flutter.git -b ${flutter_version} ) && flutter doctor && flutter config --no-analytics
