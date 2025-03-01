{ config, pkgs, lib, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.htop = {
    enable = true;
  };
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      theme = {
        name = "autumn";
      };
      sync = {
        records = true;
      };
    };
    enableZshIntegration = true;
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
    };
    enableZshIntegration = false;
  };
  programs.git = {
    enable = true;
    userEmail = "nearsy.h@gmail.com";
    userName = "nearsyh";
    extraConfig = {
      init.defaultBranch = "main";
    };
    signing.format = "ssh";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.ripgrep = {
    enable = true;
  };
}
