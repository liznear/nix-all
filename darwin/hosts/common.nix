{ config, pkgs, lib, ... }:

{
  # Manage itself.
  programs.home-manager = {
    enable = true;
  };

  imports = [
    ../../home/zsh.nix
    ../../home/starship.nix
  ];
}
