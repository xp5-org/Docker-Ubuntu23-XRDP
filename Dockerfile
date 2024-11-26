FROM ubuntu:23.10

#TZ fix for no console/headless
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# fix the apt sources ubuntu 23.10 is old
RUN sed -i.bak -e 's|archive.ubuntu.com|old-releases.ubuntu.com|g' -e 's|security.ubuntu.com|old-releases.ubuntu.com|g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    #XFCE components
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xserver-xorg-legacy \
    xdg-utils \
    dbus-x11 \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin \
    xorgxrdp \
    xrdp \
    sudo \
    # needed for firefox
    libasound2 \
    # extras for tools
    wget \
    bzip2 \
    python3 \
    python3-pip \
    build-essential 
RUN apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

# install firefox
RUN wget -O /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" --no-check-certificate
RUN tar xvf /tmp/firefox.tar.bz2 -C /opt
RUN ln -s /opt/firefox/firefox /usr/local/bin/firefox
RUN rm /tmp/firefox.tar.bz2
CMD ["firefox"]

# TODO: make audio work
# https://github.com/neutrinolabs/pulseaudio-module-xrdp

WORKDIR /app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

RUN mkdir -p /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

EXPOSE 3389
ENTRYPOINT ["/app/entrypoint.sh"]