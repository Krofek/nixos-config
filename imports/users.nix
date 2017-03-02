# Add users to system
pkgs:
{
	extraUsers = {
		krofek = {
			name = "krofek";
			group = "users";
			extraGroups = [
			"wheel" "systemd-journal"
			"networkmanager"
			"vboxusers"
			"disk" "audio" "video"
			];
			createHome = true;
			uid = 1000;
			home = "/home/krofek";
			shell = "${pkgs.zsh}/bin/zsh";
		};
	};
}
