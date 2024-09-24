FROM ubuntu:24.04
MAINTAINER Jonathan Riddell <jr@jriddell.org>
ADD public.key /
ADD bash-prompt /
RUN apt-get update && \
    apt-get install -y gnupg2
ADD neon-archive-keyring.gpg /etc/apt/keyrings/
ADD neon.sources /etc/apt/sources.list.d/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections && \
    echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y neon-settings-2 && \
    apt-get install -y ubuntu-minimal ubuntu-standard neon-desktop plasma-workspace-wayland kwin-wayland kwin-wayland-backend-x11 kwin-wayland-backend-wayland kwin-x11 && \
    apt-get dist-upgrade -y --allow-downgrades && \
    groupadd admin && \
    useradd -G admin,video -ms /bin/bash neon && \
    # Refresh apt cache once more now that appstream is installed \
    rm -r /var/lib/apt/lists/* && \
    apt-get remove --yes command-not-found && \
    apt-get update && \
    # Blank password \
    echo 'neon:U6aMy0wojraho' | chpasswd -e && \
    echo 'neon ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    apt-get clean && \
    # Wayland bits \
    mkdir /run/neon && \
    chown neon:neon /run/neon && \
    chmod 7700 /run/neon && \
    export PS1=`cat /bash-prompt`
ENV DISPLAY=:1
ENV KDE_FULL_SESSION=true
ENV SHELL=/bin/bash
ENV HOME=/home/neon
ENV XDG_RUNTIME_DIR=/run/neon
USER neon
COPY gitconfig $HOME/.gitconfig
COPY kwinrc $HOME/.config/kwinrc
RUN sudo chown -R neon.neon $HOME/.gitconfig $HOME/.config
WORKDIR /home/neon
CMD startplasma-x11