pkgs: hostname:
{
  "${hostname}" = {
    default = true;
    enableSSL = false;
    forceSSL = false;
    enableACME = false;
    serverName = hostname;
    serverAliases = [ "www.${hostname}" ];
    root = "/var/www";

    extraConfig = "index index.php index.html index.htm;";

    locations = {
      "/" = {
        tryFiles = "$uri $uri/ /index.php?$query_string";
      };

      "~ \\.php$" = {
        tryFiles = "$uri /index.php =404";
        extraConfig = ''
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass unix:/run/phpfpm/nginx;
          fastcgi_index index.php;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          include ${pkgs.nginx}/conf/fastcgi_params;
        '';
      };
    };
  };
}
