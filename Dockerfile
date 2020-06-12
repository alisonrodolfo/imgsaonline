# ----------------------------------
# Environment: Debian
# ----------------------------------
FROM        ubuntu:18.04

LABEL       author="Alison Barreiro" maintainer="equipemasters@live.com"

ENV         DEBIAN_FRONTEND noninteractive

RUN     dpkg --add-architecture i386 \
        && apt update -y \
        && apt upgrade -y  \
        && apt install -y binutils cpp gcc make psmisc  libgcc1:i386 zlib1g:i386 libc6:i386 libncurses5:i386 libstdc++6:i386 libstdc++6 lib32stdc++6 vim unzip wget perl tar curl iproute2 openssl  \
        && apt install -y libtbb2:i386 libtbb-dev:i386  \
        && useradd -d /home/container -m container

RUN     ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN     apt-get install -y tzdata
RUN     dpkg-reconfigure --frontend noninteractive tzdata

ENV         USER=container HOME=/home/container

WORKDIR    /home/container

USER     container

COPY     ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
