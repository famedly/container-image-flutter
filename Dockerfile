FROM cirrusci/android-sdk:29-ndk

LABEL maintainer="info@famedly.com"

ARG flutter_version
ENV PATH ${PATH}:/opt/flutter/flutter/bin

WORKDIR /opt/flutter

RUN mkdir -p /opt/flutter && curl https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${flutter_version}-stable.tar.xz --output ./flutter.tar.xz && tar xf ./flutter.tar.xz && rm ./flutter.tar.xz
RUN flutter precache
RUN apt-get update \
    && apt-get install --no-install-recommends -y chromium=79.0.3945.130-1~deb10u1  \
    && rm -rf /var/lib/apt/lists/*
