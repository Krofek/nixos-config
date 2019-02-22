# Networking setup
{
  hostName = "krofox";
  networkmanager = {
    enable = true;
  };
  firewall.enable = false;

  extraHosts =
  ''
  192.168.11.22 ta-dash-drupal.local ta-dash-laravel.local
  192.168.99.99 coincodextv.local api.permakultura.local api.seedling.local testing.local
  192.168.34.34 ta-dashboard.local
  192.168.17.17 porndeals.local
  '';

  nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "wlp3s0";
  };
}
