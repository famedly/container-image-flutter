ARG cypress_version
FROM cypress/included:${cypress_version}

LABEL maintainer="info@famedly.com"

RUN apt update

RUN apt install curl jq debian-keyring debian-archive-keyring apt-transport-https docker.io ldnsutils grep libolm3 -y
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt update && apt upgrade -y
RUN apt install caddy
RUN rm -rf /var/lib/apt/lists/*

