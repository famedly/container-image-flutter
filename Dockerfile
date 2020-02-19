ARG android_image
FROM ${android_image}

LABEL maintainer="info@famedly.com"

ARG flutter_version_url

WORKDIR /opt/flutter
ENV PATH /opt/flutter/flutter/bin:$PATH

# Get openssl, axel, lcov and gcc
RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends -y openssl axel lcov gcc \
    && sudo rm -rf /var/lib/apt/lists/*

# Install flutter
RUN mkdir -p /opt/flutter && sudo chown -R famedly:famedly /opt/flutter && axel --output ./flutter.tar.xz "${flutter_version_url}" && tar xf ./flutter.tar.xz && rm ./flutter.tar.xz && sudo chown -R famedly:famedly /opt/flutter
RUN flutter config --enable-web && flutter doctor

# Make sure we have UTF-8
RUN echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment && echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen && echo "LANG=en_US.UTF-8" | sudo tee -a /etc/locale.conf && sudo locale-gen en_US.UTF-8

WORKDIR /home/flutter
    
