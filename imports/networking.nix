# Networking setup
{
  hostName = "krofox";
  networkmanager = {
    enable = true;
    /*unmanaged = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" "ve-ta" ];*/
  };
  firewall.enable = false;

  nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "wlp3s0";
  };
}
