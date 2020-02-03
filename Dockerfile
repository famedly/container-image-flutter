ARG android_image
FROM ${android_image}

LABEL maintainer="info@famedly.com"

ARG flutter_version_url
ENV PATH ${PATH}:/opt/flutter/flutter/bin

WORKDIR /opt/flutter

RUN mkdir -p /opt/flutter && sudo chown -R famedly:famedly /opt/flutter && curl "${flutter_version_url}" --output ./flutter.tar.xz && tar xf ./flutter.tar.xz && rm ./flutter.tar.xz && sudo chown -R famedly:famedly /opt/flutter
RUN flutter precache && flutter config --enable-web && flutter doctor
#RUN sudo apt-get update \
#    && sudo apt-get install --no-install-recommends -y chromium=79.0.3945.130-1~deb10u1  \
#    && sudo rm -rf /var/lib/apt/lists/*
