FROM fedora:latest
ENV USERNAME=tiled GID=1000 UID=1000
RUN useradd -m tiled
RUN mkdir /run/user/1000
ENV XDG_RUNTIME_DIR /run/user/1000
RUN dnf -y install tiled
WORKDIR /
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["start.sh"]
