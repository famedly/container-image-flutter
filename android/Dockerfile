FROM alpine:3.17

LABEL maintainer="info@famedly.com"

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

ENV ANDROID_SDK_TOOLS=9123335 GLIBC_VERSION=2.34-r0 ANDROID_HOME=/opt/android/sdk ANDROID_SDK_ROOT=/opt/android/sdk ADB_INSTALL_TIMEOUT=120 JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH=${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

# Add pubkey for glibc package
COPY sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub

# Install java and ruby and glibc dependencies for android and (later) flutter
RUN apk add --no-cache curl openjdk11 ruby-full ruby-dev ruby-rdoc make g++ bash curl unzip git gzip tar xz jq openssh-client tzdata python3 \
 && apk add lcov --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
 && apk add --force-overwrite glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
 && apk fix --force-overwrite alpine-baselayout-data \
 && rm glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
 && gem install fastlane && fastlane --version

# Add coverage script
RUN curl -o /bin/lcov_cobertura.py https://raw.githubusercontent.com/eriwen/lcov-to-cobertura-xml/master/lcov_cobertura/lcov_cobertura.py && sed 's/env python/env python3/' -i /bin/lcov_cobertura.py && chmod +x /bin/lcov_cobertura.py

# Download and install Android SDK
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    curl https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip | busybox unzip -d ${ANDROID_SDK_ROOT}_temp - && mv ${ANDROID_SDK_ROOT}_temp/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && rm -R ${ANDROID_SDK_ROOT}_temp && chmod +x ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/*

RUN yes | sdkmanager --licenses

# Update SDK manager and install system image, platform and build tools
# We need to install all required platforms, but we try to only have one ndk (to
# keep size down) and have only one verion of the build tools. CMake versions
# are added as dependencies require them.
RUN sdkmanager \
  "tools" \
  "platform-tools" \
  "build-tools;30.0.3" \
  "cmake;3.18.1" \
  "cmake;3.22.1" \
  "platforms;android-33" \
  "platforms;android-32" \
  "platforms;android-31" \
  "platforms;android-30" \
  "platforms;android-29" \
  "platforms;android-28" \
  "ndk;21.4.7075529" \
 && sdkmanager --uninstall "emulator"
