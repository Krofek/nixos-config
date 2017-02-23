{pkgs, ...}: {
  # locale
	i18n = {
		consoleFont = "Lat2-Terminus16";
		consoleKeyMap = "us";
		defaultLocale = "en_US.UTF-8";
	};

  # timeTZ
	time.timeZone = "Europe/Ljubljana";

  # audio
	hardware.pulseaudio.enable = true;

  # tools
	programs = {
		zsh.enable = true;
		ssh.startAgent = true;
		bash.enableCompletion = true;
	};
}
