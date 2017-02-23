pkgs: let

sessionCommands = ''
# Launch pulse audio applet
# ${pkgs.pa_applet}/bin/pa-applet &
# Launch nm applet
${pkgs.networkmanagerapplet}/bin/nm-applet &
'';

in 
{
  enable = true;
  layout = "us";
  xkbOptions = "eurosign:e";

  displayManager.sessionCommands = sessionCommands;

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
