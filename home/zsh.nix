{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
    };
    shellAliases = {
      ll = "ls -la";
      j = "just";
      za = "zellij attach";
    };
    initContent = ''
function dinit() {
  nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1"
}

# asdf
. "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
autoload -Uz bashcompinit && bashcompinit
. "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
. ~/.asdf/plugins/golang/set-env.zsh
'';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];
  };
}
