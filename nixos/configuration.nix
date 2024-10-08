{ config, pkgs, ... }:

{
  imports =
    [
# ./uncommon/dbs.nix
    ./uncommon/hardware-configuration.nix
      ./uncommon/audio.nix
      ./uncommon/uncommon.nix
      ./uncommon/locale.nix
      # ./home-manager.nix
      ./pkgs.nix
      ./wm.nix
      ./wireless.nix
      ./vpn.nix
      ./tor.nix
      ./cron.nix
    ];
  # boot.extraModulePackages = [config.boot.kernelPackages.wireguard];

  environment.sessionVariables.NIXOS_CONFIG = "/home/ardi/nixos/configuration.nix";

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  hardware.bluetooth.settings = {
          General = {
                  Experimental = true;
          };
  };

  virtualisation.docker.enable = true;
  # virtualisation.docker.storageDriver = "btrfs";

  users.users.ardi = {
    isNormalUser = true;
    description = "Orion Gonzalez";
    extraGroups = [ "wheel" "networkmanager" "docker" "uinput"];
    hashedPassword = "$y$j9T$Lxqx4S.07BJu55J3f4MvA/$d7n1xcH5TUdPqSRTpeZMVXVKpRV4AQUUiW7r0edH7zD";
  };

  programs.mtr.enable = true;
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.direnv.enable = true;

  services.openssh.enable = true;
  services.kanata.enable = true;
  services.atuin.enable = true;

  services.kanata.keyboards.foo.extraDefCfg = "process-unmapped-keys yes";
  services.kanata.keyboards.foo.config = ''
(defsrc spc)

(defalias
  oneshot_shift (one-shot-press 500 lsft)
  oneshot_alt (one-shot-press 500 lalt) 
  taphold_esc_lctl (tap-hold-press 150 500 esc lctl)
  oneshot_meta (one-shot-press 500 lmet)
  esc_sequence (multi tab w S-tab)
)

(deflayermap (base-layer)
  lsft @oneshot_shift
  rsft @oneshot_shift
  lalt @oneshot_alt  
  ralt C-b 
  caps @taphold_esc_lctl 
  lmet @oneshot_meta
  rmet @oneshot_meta
  esc  @esc_sequence
  lctl XX
  rctl XX
)  '';
}
