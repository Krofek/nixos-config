# Nixpkgs settings
{
  config = {
		allowUnfree = true;

		firefox = {
			enableGoogleTalkPlugin = false;
			enableAdobeFlash = false;
		};

		chromium = {
			enablePepperFlash = true;
			enablePepperPDF = true;
		};
  };
}
