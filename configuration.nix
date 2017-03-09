{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./imports/locale.nix
		./imports/system.nix
		./imports/containers.nix
		./imports/services/i3status.nix
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
}
