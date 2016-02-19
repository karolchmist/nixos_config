{ config, lib, pkgs, ... }:

{
	hardware = {
		bluetooth.enable = true;
	};

	services.xserver = {
		xkbModel = "pc105";

		synaptics = {
			enable = true;
			twoFingerScroll = true;
			tapButtons = false;
		};
	};
}
