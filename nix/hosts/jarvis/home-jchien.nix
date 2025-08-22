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
  home.homeDirectory = "/home/${config.home.username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nixfmt
    nixd

    # editor
    vim
    neovim

    # git
    git
    lazygit

    # secret
    age
    sops

    fzf
    ripgrep
    fd
    bat
    eza
    vivid
    rsync
    newt # for whiptail
    broot
    yazi
    zoxide
    moreutils # for vipe
    asdf
    direnv
    pipx
    uv
    pnpm
    aria2
    zsh
    podman
    podman-compose
    podman-tui
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    ".config/aria2" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/aria2/nix";
    };
    ".config/git" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/git/nix";
    };
    ".config/alacritty" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/alacritty/nix";
    };
    ".config/wezterm" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/wezterm/nix";
    };
    ".config/tmux" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/tmux/nix";
    };
    ".config/zsh" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/zsh/nix/zinit-fancy";
    };
    ".zshenv" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/zsh/nix/.zshenv";
      force = true;
    };
    ".config/nvim" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/neovim/astronvim/nix";
    };
    ".config/broot/conf.hjson" = {
      source = mkOutOfStoreSymlink "${dotfilesDirectory}/broot/nix/conf.hjson";
      force = true;
    };
  };
}
