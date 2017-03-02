# Nginx server users
pkgs: {
  "webserv" = {
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/webserv";
    extraGroups = [ "users" "wheel" ];
    shell = "${pkgs.zsh}/bin/zsh";
    isNormalUser = true;
  };

  "www-data" = {
    uid = 33;
    group = "www-data";
    home = "/srv/www";
    createHome = true;
    useDefaultShell = true;
  };
}
