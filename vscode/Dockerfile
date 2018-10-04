FROM tegieng7/vscode
# Haxe
RUN apt-get update && apt-get -y install software-properties-common
RUN sudo add-apt-repository ppa:haxe/releases -y
RUN apt-get update && apt-get -y install haxe sudo build-essential
#RUN rm -rf /var/lib/apt/lists/*
RUN echo ${USERNAME} 'ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN mkdir -p /code/haxelib
RUN chown ${USERNAME}:${USERNAME} /code/haxelib
RUN echo 'sudo -H -u ${USERNAME} haxelib --always "$@"' >.haxelib.sh
RUN chmod 744 .haxelib.sh
RUN ./.haxelib.sh setup /code/haxelib
# HaxeFlixel
RUN ./.haxelib.sh install lime
RUN ./.haxelib.sh install openfl
RUN ./.haxelib.sh install flixel
RUN ./.haxelib.sh run lime setup flixel
RUN yes | ./.haxelib.sh run lime setup
RUN ./.haxelib.sh install flixel-tools
RUN printf 'y\n3\ny\n' | ./.haxelib.sh run flixel-tools setup
RUN ./.haxelib.sh update
# Visual Studio Code
RUN apt-get -y install locales
ENV LC_ALL=en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN yes 1 | dpkg-reconfigure locales
RUN ${VSCODE} --install-extension openfl.lime-vscode-extension
RUN ${VSCODE} --install-extension vscodevim.vim
RUN chown -R ${USERNAME}:${USERNAME} /code
RUN chmod -R a+rw /code
# Flash player
WORKDIR /usr/local/bin
COPY flash_player_sa_linux_debug.x86_64.tar.gz .
RUN tar xf flash_player_sa_linux_debug.x86_64.tar.gz flashplayerdebugger
COPY flashplayerdebugger.sh .
RUN chmod +x flashplayerdebugger.sh
RUN apt-get -y install xdg-utils
RUN echo 'application/x-shockwave-flash; flashplayerdebugger.sh %s' >>/etc/mailcap
RUN apt-get -y install gtk2-engines-murrine murrine-themes
# Startup
WORKDIR /
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["start.sh"]
CMD ["/usr/bin/code", "--user-data-dir", "/code/config", "--extensions-dir", "/code/extensions"]
