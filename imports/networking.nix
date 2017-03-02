# Networking setup
{
  hostName = "krofox";
  networkmanager = {
    enable = true;
    unmanaged = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" "ve-ta" ];
  };
  firewall.enable = false;
  extraHosts = ''
  192.168.11.11 ta.local
  '';
}
