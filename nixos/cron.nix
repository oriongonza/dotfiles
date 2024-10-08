{ config, pkgs, ... }:
{

  systemd.services.dotfiles-sync = {
    description = "Sync dotfiles to Git daily";
    script = ''
      /home/ardi/dotfiles/git_sync.sh
      '';
    serviceConfig = {
      Type = "oneshot";
      User = "ardi";
        WorkingDirectory = "/home/ardi/dotfiles";
    };
  };

  systemd.services.notes-sync = {
    description = "Sync dotfiles to Git daily";
    script = ''
      /home/ardi/dotfiles/git_sync.sh
      '';
    serviceConfig = {
      Type = "oneshot";
      User = "ardi";
        WorkingDirectory = "/home/ardi/repos/notes";
    };
  };
}
