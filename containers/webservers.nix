{ lib, pkgs, config, ... }:

let

  mkContainer = { net, oct, name, type ? "default", ... }:
  let
    vhostsConf = if type == "drupal"
                 then ../conf/nginx.drupal.nix
                 else ../conf/nginx.default.nix;
  in
  {
    privateNetwork = true;
    hostAddress = "${net}.1";
    localAddress = "${net}.${oct}";

    config = { config, pkgs, ...}:
    {
      networking.hostName = name;
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 ];
      };

      programs.zsh.enable = true;

      environment.systemPackages = with pkgs; [
          vim git wget
          php
          phpPackages.composer
          phpPackages.imagick
          phpPackages.memcached
          phpPackages.xdebug
      ];

      services.nginx = {
        enable = true;
        user = "www-data";
        group = "www-data";
        recommendedOptimisation = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        virtualHosts = import vhostsConf pkgs name;
      };

      services.phpfpm.poolConfigs.nginx = ''
        listen = /run/phpfpm/nginx
        listen.owner = www-data
        listen.group = www-data
        listen.mode = 0660
        user = www-data
        pm = dynamic
        pm.max_children = 75
        pm.start_servers = 10
        pm.min_spare_servers = 5
        pm.max_spare_servers = 20
        pm.max_requests = 500
        php_flag[display_errors] = off
        php_admin_value[error_log] = "/run/phpfpm/php-fpm.log"
        php_admin_flag[log_errors] = on
        php_value[date.timezone] = "UTC"
        php_value[upload_max_filesize] = 10G
        env[PATH] = /srv/www/bin:/var/setuid-wrappers:/srv/www/.nix-profile/bin:/srv/www/.nix-profile/sbin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/run/current-system/sw/bin/run/current-system/sw/sbin
      '';

    /*services.phpfpm.phpIni = pkgs.runCommand "php.ini"
        {
          options = ''
            zend_extension=${pkgs.phpPackages.xdebug}/lib/php/extensions/xdebug.so
            max_execution_time = 30
          '';
        }
        ''
          cat ${pkgs.php}/etc/php-recommended.ini > $out
          echo "$options" >> $out
        '';*/

      users.extraUsers = import ../conf/nginx.user.nix pkgs;
      users.extraGroups."www-data".gid = 33;
    };
  };

in
{
  containers.ta = mkContainer {
    net = "192.168.11";
    oct = "11";
    name = "ta.local";
  };
}
