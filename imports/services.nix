# Services
pkgs:
{
  openssh.enable = true;
  locate.enable = true;
  nixosManual.showManual = true;
  printing.enable = true;

  i3status.enable = true;

  xserver = import ./xserver.nix pkgs;
}
