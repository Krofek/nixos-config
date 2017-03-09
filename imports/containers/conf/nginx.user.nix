# Nginx server users
pkgs: nginxUser:
{
  extraUsers = {
    "${nginxUser}" = {
      group = nginxUser;
      uid = 33;
      createHome = true;
      home = "/home/${nginxUser}";
      extraGroups = [ "users" "wheel" ];
      shell = "${pkgs.zsh}/bin/zsh";
      isNormalUser = true;
    };
  };

  extraGroups."${nginxUser}".gid = 33;
}
