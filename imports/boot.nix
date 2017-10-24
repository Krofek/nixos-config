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

  kernel.sysctl = {"vm.max_map_count" = 262144;};
}
