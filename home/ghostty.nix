{ config, pkgs, lib, ... }:

{
  enable = true;
  enableZshIntegration = true;
  settings = {
    theme = "catppuccin-latte";
    font-family = "mononoki";
    font-size = 16;
  };
}
