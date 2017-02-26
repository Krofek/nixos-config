{ lib, pkgs, config, ... }:

let
  webservUser = {
    name = "webserv";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/webserv";
    extraGroups = [ "users" "wheel" ];
    shell = "${pkgs.zsh}/bin/zsh";
    isNormalUser = true;
  };

  mkContainer = { net, octet, hostname, type ? "default" }:
  let
    vhostsConf = if type == "drupal" then ../conf/nginx.drupal.nix
                                     else ../conf/nginx.default.nix;
  in
  {
    privateNetwork = true;
    hostAddress = "${net}.1";
    localAddress = "${net}.${octet}";

    config = { config, pkgs, ...}:
    {
      networking.hostName = hostname;
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 ];
      };

      programs.zsh.enable = true;

      services.nginx = {
        enable = true;
        recommendedOptimisation = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        virtualHosts = import vhostsConf hostname;
      };

      users.extraUsers.webserv = webservUser;
    };
  };

in
{
  containers.ta = mkContainer {
    net = "192.168.11";
    octet = "11";
    hostname = "ta.local";
  };
}
