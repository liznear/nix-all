{ opAgent, prefix, ... }:

{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
  };

  home.file.".ssh/config".text = ''
${prefix}

Host *
  IdentityAgent "${opAgent}"

Host lizgit
  HostName github.com
  User git
  IdentityFile ~/.ssh/liz.pub

Host neargit
  HostName github.com
  User git
  IdentityFile ~/.ssh/near.pub

Host mini-ubuntu
  HostName 192.168.2.207
  User nearsyh
  IdentityFile ~/.ssh/near.pub

Host mini-nix
  HostName 192.168.64.6
  User nearsyh
  IdentityFile ~/.ssh/near.pub
  SetEnv TERM=xterm-256color
'';

  home.file.".ssh" = {
    source = ./configs;
    # copy the scripts directory recursively
    recursive = true;
  };
}
