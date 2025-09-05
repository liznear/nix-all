{ prefix, ... }:

{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  home.file.".ssh/config".text = ''
${prefix}

Host lizgit
  HostName github.com
  User git
  IdentityFile ~/.ssh/liz.pub

Host neargit
  HostName github.com
  User git
  IdentityFile ~/.ssh/near.pub

Host linux-home
  HostName 192.168.2.159
  User nearsyh
  ForwardAgent yes
  IdentityFile ~/.ssh/liz.pub
  SetEnv TERM=xterm-256color

Host umbrel
  HostName 192.168.2.207
  User umbrel
  ForwardAgent yes
'';

  home.file.".ssh" = {
    source = ./configs;
    # copy the scripts directory recursively
    recursive = true;
  };
}
