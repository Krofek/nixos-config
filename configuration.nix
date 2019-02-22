{ config, pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
		./imports/system.nix
		./imports/i3status-configurator
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
	environment.systemPackages = import ./imports/packages.nix { inherit pkgs; };

	# services
	services = import ./imports/services.nix { inherit pkgs; };

	# users
	users = import ./imports/users.nix { inherit pkgs; };

	# extra tools
	tools.i3status-configurator.enable = true;

	# containers
	# containers = import ./imports/containers.nix {
	# 	inherit config pkgs lib;
	# };
}
