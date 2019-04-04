{ config, lib, pkgs, ... }:

{
	hardware = {
		bluetooth.enable = true;
	};

	services.xserver = {
		xkbModel = "pc105";

		libinput = {
			enable = true;
		};
	};
}
