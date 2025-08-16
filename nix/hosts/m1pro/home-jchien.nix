{
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfilesDirectory = "${config.home.homeDirectory}/dotfiles";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{

  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home.username = "jchien";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = with pkgs; [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    ".config/aria2" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/aria2/nix";
    };
    ".config/git" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/git/nix";
    };
    ".config/tig" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/tig/nix";
    };
    ".config/alacritty" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/alacritty/nix";
    };
    ".config/yt-dlp" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/yt-dlp/nix";
    };
    ".config/yabai" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/yabai/nix";
    };
    ".config/wezterm" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/wezterm/nix";
    };
    ".config/streamlink" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/streamlink/nix";
    };
    ".config/spacebar" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/spacebar/nix";
    };
    ".config/skhd" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/skhd/nix";
    };
    ".config/lf" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/lf/nix";
    };
    ".config/tmux" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/tmux/nix";
    };
    ".config/karabiner" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/karabiner/nix";
    };
    ".config/zsh" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/zsh/nix/zinit-fancy";
    };
  };
}
