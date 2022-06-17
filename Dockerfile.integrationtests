ARG flutter_image
FROM ${flutter_image}

LABEL maintainer="info@famedly.com"

RUN sdkmanager 'emulator' 'system-images;android-30;google_apis;x86' && rm -rf /opt/android/sdk/emulator-2
RUN avdmanager create avd --force --package 'system-images;android-30;google_apis;x86' --device pixel_4_xl --name test
RUN apk add --no-cache mesa-gl nodejs npm
