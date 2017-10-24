{ pkgs, ... }:

# Services
{
  openssh.enable = true;
  locate.enable = true;
  nixosManual.showManual = true;
  printing.enable = true;
  teamviewer.enable = true;

  redshift = {
    enable = true;
    latitude = "46.0310266";
    longitude = "14.4933957";
  };

  postgresql = {
    enable = true;
    authentication = ''
      # Generated file; do not edit!
      local all all                trust
      host  all all 127.0.0.1/32   trust
      host  all all ::1/128        trust
      host  all all 192.168.1.0/24 trust
    '';
  };

  xserver = import ./xserver.nix { inherit pkgs; };
}
