{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./imports/system.nix
		./nixos-i3status-configurator/default.nix
		./nixos-webtainers/default.nix
	];

	# boot and grub options
	boot = import ./imports/boot.nix;

	# networking
	networking = import ./imports/networking.nix;

	# custom packages path
	nix.nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ];

	# nixpkgs setup
	nixpkgs = import ./imports/nixpkgs.nix;

	# system wide packages
	environment.systemPackages = import ./imports/packages.nix pkgs;

	# services
	services = import ./imports/services.nix pkgs;

	# users
	users = import ./imports/users.nix pkgs;

	# extra tools
	tools = {
		webtainers = {
	    "tests" = {
	      net = "192.168.11";
	      lastOctave = "12";
	      bindMounts = {
	        "/var/www/tests.local" = {
	          hostPath = "/home/krofek/projects/tests";
	          isReadOnly = false;
	        };
	      };
	    };
	  };

		i3status-configurator.enable = true;
	};
}
