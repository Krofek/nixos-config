# System wide common settings
{
  # audio
	hardware.pulseaudio.enable = true;

	# virtualbox
	virtualisation.virtualbox.host.enable = true;

  # tools
	programs = {
		zsh.enable = true;
		ssh.startAgent = true;
		bash.enableCompletion = true;
	};
}
