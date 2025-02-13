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
  programs.git = {
    enable = true;
    userEmail = "nearsy.h@gmail.com";
    userName = "nearsyh";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
