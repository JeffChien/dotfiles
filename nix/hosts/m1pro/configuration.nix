{
  pkgs,
  libs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/homebrew/configuration.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.jchien = {
    name = "jchien";
    home = "/Users/jchien";
  };
  system.primaryUser = "jchien";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jchien = ./home-jchien.nix;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nixfmt
    nixd

    # editor
    vim
    neovim

    # git
    git
    lazygit

    # k8s
    k9s
    kubectl

    # secret
    age
    sops

    audacity
    asdf-vm
    stow
    iina
    iterm2
    skimpdf
    fzf
    ripgrep
    fd
    bat
    eza
    vivid
    kubectx
    mpv-unwrapped
    rsync
    newt # for whiptail
    broot
    yazi
    zoxide
    moreutils # for vipe
  ];
  homebrew = {
    enable = true;
    brews = [
      "coreutils"
      "gnu-sed"
      "gnu-getopt"
      "gnu-tar"
      "findutils"
    ];
    casks = [ ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false; # deplay compinit, this prevent generating unwanted zcompdump file.

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

}
