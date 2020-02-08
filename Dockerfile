ARG android_image
FROM ${android_image}

LABEL maintainer="info@famedly.com"

ARG flutter_version_url

WORKDIR /opt/flutter
ENV PATH "${PATH}:/home/famedly/.rvm/bin:/opt/flutter/flutter/bin"

# Install flutter
RUN mkdir -p /opt/flutter && sudo chown -R famedly:famedly /opt/flutter && curl "${flutter_version_url}" --output ./flutter.tar.xz && tar xf ./flutter.tar.xz && rm ./flutter.tar.xz && sudo chown -R famedly:famedly /opt/flutter
RUN flutter precache && flutter config --enable-web && flutter doctor


#RUN sudo apt-get update \
#    && sudo apt-get install --no-install-recommends -y chromium=79.0.3945.130-1~deb10u1  \
#    && sudo rm -rf /var/lib/apt/lists/*

# Make sure we have UTF-8
RUN echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment && echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen && echo "LANG=en_US.UTF-8" | sudo tee -a /etc/locale.conf && sudo locale-gen en_US.UTF-8

# Get openssl
RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends -y openssl curl  \
    && sudo rm -rf /var/lib/apt/lists/*

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c ". /home/famedly/.rvm/scripts/rvm && rvm install 2.7"
RUN /bin/bash -l -c ". /home/famedly/.rvm/scripts/rvm && gem install bundler"
WORKDIR /home/flutter
    
