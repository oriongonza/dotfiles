{ config, libs, pkgs, ... }:

{
  services.libinput.enable = true;

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "ardi";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  environment.systemPackages = with pkgs; [
    hyprland
      wl-clipboard
      xdg-utils
      vesktop
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-hyprland
    ];
  };

  programs = {
    hyprland = {
      enable = true;
    };
    xwayland = {
      enable = true;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

}
