I don’t intend to set up a native NixOS environment—my sole purpose is to use it as a package manager.  
On macOS, `nix-darwin` provides functionality similar to native NixOS, allowing you to configure OS-related settings through the Nix configuration file.  
For other Linux distributions, simply use `home-manager` for user-based package management.

## Bootstrap
To install the necessary commands

```shell
# MacOS boostrap, to install darwin-build command
sudo nix run nix-darwin/master#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#m1pro

## home manager boostrap, to install home-manager command
nix run nixpkgs#home-manager -- switch --flake <flake-file-path>#<USERNAME>

# another boostrap, this will automatically create a base config under .confg/home-manager
nix run home-manager/master -- init --switch
```

## Build profile and upgrade packages.

### To build a new version of profile
```shell
## NixOS and MacOS

# rebuild nix in mac, the last part is short for `<dir>/flake.nix#<config_name>`
sudo nix-rebuild switch --flake <relative_path>#<profile_name>

# rebuild nix in mac, the last part is short for `<dir>/flake.nix#<config_name>`
sudo darwin-rebuild switch --flake .#m1pro


## Home manager (stand-alone)
home-manager switch --flake <path>#<profile_name>
```

### To upgrade packages
For my mac
```shell
# this update packages
nix flake update

# partial update, speed up process. https://youtu.be/HEt6b418Ueo?t=809
nix flake lock --update --update-input <input_name>
```

For other linux distributions
```shell
nix-channel --update; home-manager switch <path>#<profile_name>
```

## keep total N generations(versions) and GC old packages

```shell
# list profiles for system profile
sudo -i nix-env --list-generations -p /nix/var/nix/profiles/system

# list profiles for user
sudo -i nix-env --list-generations

# keep last 5 generations of system profile
sudo -i nix-env -p /nix/var/nix/profiles/system --delete-generations +5

# keep last 5 generations of user profile
sudo -i nix-env --delete-generations +5
```

```shell
# normal GC, remote detached elements, the follwing 2 are equivalent
nix-collect-garbage
# nix store gc

# GC + remove older profiles. To retain the last N profiles, it is necessary to set a sufficiently large value for this parameter, thereby preventing the accidental deletion of profiles.
nix-collect-garbage --delete-older-than 90d
```
