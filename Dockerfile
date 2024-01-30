FROM ubuntu:23.04

#TZ fix for no console/headless
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xserver-xorg-legacy \
    dbus-x11 \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin \
    libasound2 \
    sudo \
    wget \
    bzip2 \
    python3 \
    python3-pip \
    xorgxrdp \
    xrdp && \
    apt remove -y light-locker xscreensaver && \
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

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir -p /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession


EXPOSE 3389
ENTRYPOINT ["/usr/bin/entrypoint.sh"]