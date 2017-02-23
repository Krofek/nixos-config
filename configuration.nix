{ config, pkgs, ... }:

{
	imports = [
	./hardware-configuration.nix
	./imports/system.nix
	];

	# boot and grub options
	boot = import ./imports/boot.nix pkgs;

	# networking
	networking = import ./imports/networking.nix pkgs;

	# custom packages path
	nix.nixPath = [ "/etc/nixos" "nixos-config=/etc/nixos/configuration.nix" ];

	# nixpkgs setup
	nixpkgs = import ./imports/nixpkgs.nix pkgs;

	# system wide packages
	environment.systemPackages = import ./imports/packages.nix pkgs;

	# services
	services = import ./imports/services.nix pkgs;

	# users
	users = import ./imports/users.nix pkgs;
}
