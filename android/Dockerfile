FROM alpine:3.13

LABEL maintainer="info@famedly.com"

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

ENV ANDROID_SDK_TOOLS=7302050 GLIBC_VERSION=2.33-r0 ANDROID_HOME=/opt/android/sdk ANDROID_SDK_ROOT=/opt/android/sdk ADB_INSTALL_TIMEOUT=120 
ENV PATH=${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

# Add pubkey for glibc package
COPY sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub

# Install java and ruby and glibc dependencies for android and (later) flutter
RUN apk add --no-cache curl openjdk8 ruby ruby-dev ruby-rdoc make g++ bash curl unzip git gzip tar xz jq openssh-client \
 && apk add lcov --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
 && apk add glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
 && rm glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
 && gem install fastlane && fastlane --version

# Download and install Android SDK
RUN mkdir -p ${ANDROID_SDK_ROOT} && \
    curl https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip | busybox unzip -d ${ANDROID_SDK_ROOT} - && mkdir ${ANDROID_SDK_ROOT}/cmdline-tools/latest && mv ${ANDROID_SDK_ROOT}/cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/latest || true && chmod +x ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/*

RUN yes | sdkmanager --licenses

# Update SDK manager and install system image, platform and build tools
# We try to keep the last 2 build tools and platforms around, but only the latest ndk to keep the size down.
RUN sdkmanager \
  "tools" \
  "platform-tools" \
  "build-tools;29.0.3" \
  "build-tools;30.0.3" \
  "cmake;3.10.2.4988404" \
  "platforms;android-28" \
  "platforms;android-29" \
  "platforms;android-30" \
  "ndk;21.4.7075529" \
 && sdkmanager --uninstall "emulator"