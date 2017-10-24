{ config, pkgs, lib, ...}:

with lib;

let
  mkVhosts = lib.mapAttrs' (name: options:
    lib.nameValuePair (name) (mkVhost name options)
  );

  mkVhost = name: options: {
    default = options.default;
    enableSSL = false;
    forceSSL = false;
    enableACME = false;
    serverName = "${name}";
    serverAliases = [ "www.${name}" ];
    root = options.root;

    extraConfig = "index index.html index.htm index.php;";

    locations = {
      "/" = {
        tryFiles = "$uri $uri/ /index.php?$query_string";
      };

      "~ \\.php$" = {
        tryFiles = "$uri /index.php =404";
        extraConfig = ''
          include ${pkgs.nginx}/conf/fastcgi_params;
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass 127.0.0.1:9000;
          fastcgi_index index.php;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        '';
      };
    };
  };

  mkSystemPackages = with pkgs; [
    vim git wget unzip
    rxvt_unicode
    php
    phpPackages.composer
    phpPackages.imagick
    phpPackages.memcached
    phpPackages.xdebug
    nodejs
    mysql
  ];

  mkOpenSsh = address: {
      enable = true;
      listenAddresses = [{
        addr = address;
        port = 22;
      }];
  };

  mkMysql = options: {
    enable = true;
    package = pkgs.mariadb;
    extraOptions = ''
      bind-address              = 0.0.0.0
      wait_timeout              = 600
      max_allowed_packet        = 16M
      innodb_buffer_pool_size   = 256M
    '';
  };

  mkPhpFpm = options: {
    phpOptions = ''
      date.timezone = "${options.timezone or "Europe/Ljubljana"}"
      zend_extension = "${pkgs.phpPackages.xdebug}/lib/php/extensions/xdebug.so"
      max_execution_time = 30
      post_max_size = 100M
      upload_max_size = 200M
      upload_max_filesize = 100M
      memory_limit = 512M
    '';
    poolConfigs.nginx = ''
      listen = 127.0.0.1:9000
      listen.owner = ${options.user or "webserv"}
      listen.group = users
      user = ${options.user or "webserv"}
      pm = dynamic
      pm.max_children = 75
      pm.start_servers = 10
      pm.min_spare_servers = 5
      pm.max_spare_servers = 20
      pm.max_requests = 500
    '';
  };

  mkNginx = options: {
    enable = true;
    user = "${options.user or "webserv"}";
    group = "users";
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts = mkVhosts options.vhosts;
  };

  mkUsers = options: {
    "${options.user or "webserv"}" = {
      password = "${options.user or "webserv"}";
      group = "users";
      uid = 1000;
      createHome = true;
      home = "/home/${options.user or "webserv"}";
      extraGroups = [ "users" "wheel" ];
      /*shell = "/run/current-system/sw/bin/zsh";*/
      isNormalUser = true;
    };
  };

  mkHostAddress = address: (
    concatStringsSep "." (take 3 (splitString "." address))
  ) + ".1";

  mkOpenPorts = { elasticsearch ? false, ... }:
    let elastic = if elasticsearch == true then [ 5601 9200 ] else [];
    in [ 80 443 ] ++ elastic;

in
name: options:
{
  privateNetwork = true;
  hostAddress = mkHostAddress options.address;
  localAddress = options.address;

  bindMounts = options.mounts or {};

  config = { config, pkgs, ...}:
  {
    networking = {
      hostName = name;
      firewall = {
        enable = true;
        allowedTCPPorts = options.ports or mkOpenPorts options;
      };
    };

    programs.zsh.enable = true;

    environment.systemPackages = mkSystemPackages;

    services = {
      openssh = mkOpenSsh (mkHostAddress options.address);

      mysql = mkMysql options;

      redis.enable = options.redis or false;

      elasticsearch = {
        enable = options.elasticsearch or false;
        package = pkgs.elasticsearch5;
      };

      kibana = optionalAttrs (options.elasticsearch or false) {
        enable = true;
        listenAddress = options.address;
      };

      phpfpm = mkPhpFpm options;

      nginx = mkNginx options;
    };

    users = {
      extraUsers = mkUsers options;
    };
  };
}
