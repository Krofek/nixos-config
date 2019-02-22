{ pkgs, ...}:

# Additional system packages
with pkgs;
[
    # core utils +
    wget git vim rxvt_unicode zsh telnet tcpdump
    traceroute unzip htop which subversion cvs

    # utils
    arandr
    i3lock
    networkmanagerapplet
    pa_applet
    vagrant
    x11vnc
    dmenu
    gparted ntfsprogs
    gnupg pass

    # media
    firefox
    chromium
    filezilla
    skype
    zathura
    irssi
    libreoffice
    vlc

    # dev
    atom
    vscode
    jetbrains.phpstorm
    jetbrains.pycharm-professional
    androidenv.platformTools

    # other
    /*abyss-assembler*/
]
