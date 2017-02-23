pkgs: let

krofek = {
	name = "krofek";
	group = "users";
	extraGroups = [
	"wheel"
	"networkmanager" "connman"
	"vboxusers" "systemd-journal"
	"disk" "audio" "video"
	];
	createHome = true;
	uid = 1000;
	home = "/home/krofek";
	shell = "${pkgs.zsh}/bin/zsh";
};

in
{
	extraUsers = {
		krofek = krofek;
	};
}
