{ config, lib, pkgs, ... }:

{
    programs = {
        sway = {
            enable = true;
            extraPackages = with pkgs; [
                swaylock 
                swayidle 
                xwayland 
	 	wl-clipboard
                rxvt_unicode 
                j4-dmenu-desktop # launches bemenu
                bemenu # dmenu in wayland 
                i3status
                # i3status-rust
                waybar
                mako # notification deamon
                pcmanfm # Gtk file manager
                pipewire # screen sharing
            ];
         
            extraSessionCommands = ''
                export SDL_VIDEODRIVER=wayland
                # needs qt5.qtwayland in systemPackages
                export QT_QPA_PLATFORM=wayland
                export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
                # Fix for some Java AWT applications (e.g. Android Studio),
                # use this if they aren't displayed properly:
                export _JAVA_AWT_WM_NONREPARENTING=1
                        # Firefox
                export MOZ_ENABLE_WAYLAND=1
            '';
        };
        
        waybar.enable = true;
    
        light.enable = true;
    };
}
