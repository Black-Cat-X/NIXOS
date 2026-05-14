# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_CO.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };
 #________________________________________________________________________________________________________________________
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam, us";
    variant = "us";
    options = "grp:win_space_toggle";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";
#_________________________________________________________________________________________________________________________
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.juan = {
    isNormalUser = true;
    description = "Juan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
#________________________________________________________________________________________________________________________
hardware.graphics = {
enable = true;
};
services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia = {
modesetting .enable = true;
open = false;
nvidiaSettings = true;
package = config.boot.kernelPackages.nvidiaPackages.stable;
};
boot.kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1"];
environment.sessionVariables = {
LIBVA_DRIVER_NAME = "nvidia";
XDG_SESSION_TYPE = "wayland";
GBM_BACKEND = "nvidia-drm";
__GLX_VENDOR_LIBRARY_NAME = "nvidia";
WLR_NO_HARDWARE_CURSORS = "1";
};
#________________________________________________________________________________________________________________________
programs.hyprland = {
enable = true;
xwayland.enable = true;
};
xdg.portal = {
enable = true;
extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
config.common.default = "*";
};
#_______________________________________________________________________________________________________________________
security.rtkit.enable = true;
services.pipewire = {
enable = true;
alsa.enable = true;
alsa.support32Bit = true;
pulse.enable = true;
jack.enable = true;
}; #Audio y micro
#_______________________________________________________________________________________________________________________
programs.light.enable = true; #brillo
services.tlp.enable = true; #bateria

#________________________________________________________________________________________________________________________
  environment.systemPackages = with pkgs; [

networkmanagerapplet #wifi
pavucontrol #audio
brightnessctl #brillo
pamixer #volumen

fastfetch
cava

brave
spotify
vscode
discord

kitty
swww #fondos
git
btop
tree


waybar #barra
rofi #apps
grim #caps
slurp #caps
wl-clipboard #CyP




  ];
#________________________________________________________________________________________________________________________
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
