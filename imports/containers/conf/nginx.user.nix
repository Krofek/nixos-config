# Nginx server users
pkgs: nginxUser:
{
  extraUsers = {
    "webserv" = {
      group = "users";
      uid = 1000;
      createHome = true;
      home = "/home/webserv";
      extraGroups = [ "users" "wheel" ];
      shell = "${pkgs.zsh}/bin/zsh";
      isNormalUser = true;
    };

    ${nginxUser} = {
      uid = 33;
      group = nginxUser;
      home = "/srv/www";
      createHome = true;
      useDefaultShell = true;
    };
  };
  
  extraGroups.${nginxUser}.gid = 33;
}
