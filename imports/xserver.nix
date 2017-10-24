{ pkgs, ...}:

let
  urxvtOpts = pkgs.writeText  "urxvt.conf" ''
    # Fonts
    URxvt*font:       	     xft:Monospace:pixelsize=14
    URxvt*boldFont:	         xft:Monospace:pixelsize=14
    URxvt.lineSpace:	       1
    URxvt.allow_bold:	       true

    # Colors
    *foreground:	           #CCCCCC
    URxvt*background:	       #101010
    URxvt*color0:	           #101010
    URxvt*color1:	           #960050
    URxvt*color2:	           #66aa11
    URxvt*color3:	           #c47f2c
    URxvt*color4:	           #30309b
    URxvt*color5:	           #7e40a5
    URxvt*color6:	           #3579a8
    URxvt*color7:	           #9999aa
    URxvt*color8:	           #303030
    URxvt*color9:	           #ff0090
    URxvt*color10:	         #80ff00
    URxvt*color11:	         #ffba68
    URxvt*color13:	         #bb88dd
    URxvt*color12:	         #5f5fee
    URxvt*color14:	         #4eb4fa
    URxvt*color15:	         #d0d0d0

    # Cursor
    URxvt.cursorBlink:	     true
    URxvt.cursorColor:       #657b83
    URxvt.cursorUnderline:   false

    # Misc
    URxvt.depth:	           32
    URxvt.fading:	           0
    URxvt.geometry:	         90x30
    URxvt.internalBorder:	   3
    URxvt.loginShell:	       true
    URxvt.pointerBlank:	     true
    URxvt.saveLines:	       2000
    URxvt.scrollBar:	       false
    URxvt.scrollStyle:	     rxvt
    URxvt.transparent:	     false

    # XFT config
    Xft.antialias:	         false
    Xft.autohint:	           0
    Xft.dpi:	               96
    Xft.hinting:	           true
    Xft.hintstyle:	         hintslight
    Xft.lcdfilter:	         lcddefault
    Xft.rgba:	               rgb
  '';

in
# X-Server settings
{
  enable = true;
  layout = "us";
  xkbOptions = "eurosign:e";

  displayManager.sessionCommands = ''
  # Launch pulse audio applet
  ${pkgs.pa_applet}/bin/pa-applet &

  # Launch nm applet
  ${pkgs.networkmanagerapplet}/bin/nm-applet &

  # Write urxvt config
  xrdb "${urxvtOpts}"
  '';

  desktopManager.xfce.enable = true;

  windowManager = {
    i3.enable = true;
    default = "i3";
  };

  synaptics = {
    enable = true;
    twoFingerScroll = true;
    vertEdgeScroll = false;
    tapButtons = false;
  };
}
