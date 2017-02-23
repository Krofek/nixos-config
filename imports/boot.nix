{pkgs, ...}:
{
  initrd.luks.devices = [
  {
    name = "root";
    device = "/dev/sda3";
    preLVM = true;
  }
  ];

  loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
}
