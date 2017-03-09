{ lib, pkgs, config, ... }:
let
  mkWebserverPhp = {
    net ? "192.168.11",
    lastOctave,
    hostName,
    nginxUser ? "webserv",
    phpPoolConfig ? import ./conf/nginx.phpPoolConfig.nix nginxUser,
    vhostsConfig ? import ./conf/nginx.default.nix pkgs hostName nginxUser,
    allowedTCPPorts ? [ 80 443 ],
    bindMounts ? {},
    packages ? [],
    recommendedSettings ? true,
    ...
  }:
  {
    privateNetwork = true;
    hostAddress = "${net}.1";
    localAddress = "${net}.${lastOctave}";

    bindMounts = bindMounts;

    config = { config, pkgs, ...}:
    {
      networking.hostName = hostName;
      networking.firewall = {
        enable = true;
        allowedTCPPorts = allowedTCPPorts;
      };

      programs.zsh.enable = true;

      environment.systemPackages = with pkgs; [
          vim git wget
          rxvt_unicode
          php
          phpPackages.composer
          phpPackages.imagick
          phpPackages.memcached
          phpPackages.xdebug
      ] ++ packages;

      services = {
        openssh = {
          enable = true;
          listenAddresses = [{
            addr = "${net}.1";
            port = 22;
          }];
        };

        phpfpm = {
          phpPackage = pkgs.php;
          phpOptions = import ./conf/php.ini.nix pkgs;
          poolConfigs.nginx = phpPoolConfig;
        };

        mysql = {
          enable = true;
          package = pkgs.mariadb;
          extraOptions = ''
            max_allowed_packet=40000000
            innodb_buffer_pool_size=500M
          '';
        };

        nginx = {
          enable = true;
          user = nginxUser;
          group = nginxUser;
          recommendedOptimisation = recommendedSettings;
          recommendedTlsSettings = recommendedSettings;
          recommendedGzipSettings = recommendedSettings;
          recommendedProxySettings = recommendedSettings;
          virtualHosts = vhostsConfig;
        };
      };

      users = import ./conf/nginx.user.nix pkgs nginxUser;
    };
  };
in
{
  # if net is not defined it defaults to 192.168.11
  containers = {
    tests = mkWebserverPhp {
      lastOctave = "12";
      hostName = "tests.local";
      bindMounts = {
          "/var/www/tests.local" = {
            hostPath = "/home/krofek/projects/tests";
            isReadOnly = false;
          };
      };
    };
  };
}
