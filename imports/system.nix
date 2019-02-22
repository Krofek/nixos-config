# System wide common settings
{
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

	# virtualbox
	virtualisation.virtualbox.host.enable = true;

  # tools
	programs = {
		zsh.enable = true;
		ssh.startAgent = true;
		bash.enableCompletion = true;
		browserpass.enable = true;
	};

  # fonts
	fonts = {
		enableCoreFonts = true;
		enableDefaultFonts = true;
		enableFontDir = true;
	};
}
