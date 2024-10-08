# General options that are unlikely to change.
{ config, pkgs, ... }:
  {
  security.sudo.extraConfig = ''
        Defaults env_reset,pwfeedback
    '';
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.printing.enable = true;
  security.rtkit.enable = true;
  users.defaultUserShell = pkgs.fish;

# Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

  ];

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
  system.stateVersion = "23.11";
  }
