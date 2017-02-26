hostname:
{
  "${hostname}" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      root = "/var/www";
    };
  };
}
