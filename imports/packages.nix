{ pkgs, ...}:

# Additional system packages
with pkgs;
[
    # core utils +
    wget git vim rxvt_unicode zsh telnet tcpdump
    traceroute unzip htop which subversion

    # utils
    arandr
    i3lock
    networkmanagerapplet
    pa_applet
    vagrant
    x11vnc
    dmenu
    gparted ntfsprogs
    gftp

    # media
    firefox
    skype
    zathura
    irssi

    # dev
    atom
    vscode
    jetbrains.phpstorm
    nodejs
    yarn
    androidenv.platformTools

    # other
    teamviewer
    /*abyss-assembler*/
]
