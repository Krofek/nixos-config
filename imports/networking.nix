# Networking setup
{
  hostName = "krofox";
  networkmanager = {
    enable = true;
    /*unmanaged = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" "ve-ta" ];*/
  };
  firewall.enable = false;

  extraHosts =
  ''
  192.168.11.22 ta-dash-drupal.local ta-dash-laravel.local
  192.168.66.66 growly.local www.growly.local
  #192.168.22.22 dps.local www.dps.local
  192.168.99.99 dps.local prerender-test.local api.permakultura.local api.seedling.local
  192.168.34.34 ta-dashboard.local
  '';

  nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "wlp3s0";
  };
}
