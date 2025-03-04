if status --is-interactive
  set -gx EDITOR nvim
  source ~/.config/fish/aliases.fish
  source ~/.config/fish/path.fish
  source ~/.config/fish/scripts.fish

  zoxide init fish --cmd cd | source
  atuin init fish | source
  fish_vi_key_bindings
  starship init fish | source
end

if not test -n "$DISPLAY" -a "$XDG_VTNR" -eq 1
  export _JAVA_AWT_WM_NONREPARENTING=1
  export XCURSOR_SIZE=24

  kanata &
  brightnessctl set 30%
  # exec Hyprland
end

set -gx ANDROID_HOME "/home/ardi/Android/Sdk"
# set -gx ANDROID_SDK_HOME "/home/ardi/Android/Sdk"
# set -gx ANDROID_NDK_HOME "/home/ardi/Android/Sdk/ndk/26.3.11579264"
set -gx PNPM_HOME "/home/ardi/.local/share/pnpm"

if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

set -U fish_user_paths ~/bin $fish_user_paths
set -U fish_user_paths "~/.cargo/env " $fish_user_paths
set -U RUST_LOG 1
set -U GIT_EXTERNAL_DIFF

