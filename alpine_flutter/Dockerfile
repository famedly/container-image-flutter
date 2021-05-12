FROM alpine:latest

ARG flutter_version
WORKDIR /usr

# Add pubkey for glibc package
COPY sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub

# Install all requirements, including lcov for test coverage support from alpine edge/testing repo
RUN apk add --no-cache bash curl unzip git gzip tar xz jq openssh-client \
 && apk add lcov --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk \
 && apk add glibc-2.33-r0.apk \
 && rm glibc-2.33-r0.apk

ENV FLUTTER_HOME=/usr/flutter/bin
ENV PATH=${FLUTTER_HOME}:${PATH}

RUN git clone --depth 1 https://github.com/flutter/flutter.git -b $flutter_version

RUN flutter precache --linux

WORKDIR /opt
