ARG image_base
FROM ${image_base}

ARG flutter_version
WORKDIR /usr

ENV FLUTTER_HOME=/usr/flutter/bin
ENV PATH=${FLUTTER_HOME}:${PATH}
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apk update && apk add docker drill grep olm cmake

RUN git clone --depth 1 https://github.com/flutter/flutter.git -b $flutter_version

RUN flutter precache --linux

WORKDIR /opt
