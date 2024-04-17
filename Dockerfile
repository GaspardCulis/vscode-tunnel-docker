FROM docker.io/alpine:latest

ARG USERNAME=workspace

RUN apk --no-cache add curl git nodejs npm bash starship python3

RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output /tmp/vscode_cli.tar.gz
RUN tar -xf /tmp/vscode_cli.tar.gz -C /usr/bin 
RUN rm /tmp/vscode_cli.tar.gz

RUN adduser -D -u 1000 -s /bin/bash -h /home/${USERNAME} ${USERNAME} 

WORKDIR /home/${USERNAME}
COPY conf/bashrc .bashrc
COPY conf/starship.toml .config/starship.toml

RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
VOLUME /home/${USERNAME}
CMD ["code", "tunnel", "--accept-server-license-terms", "--disable-telemetry"]
