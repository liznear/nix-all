{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
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
export PATH="~/.asdf/shims:$PATH"
. "${pkgs.asdf-vm}/share/bash-completion/completions/asdf.bash"
autoload -Uz bashcompinit && bashcompinit
. ~/.asdf/plugins/golang/set-env.zsh

export PATH="$HOME/.cargo/bin:$PATH"

export GITHUB_TOKEN=op://Private/GitHub_Liz/token
export OPENROUTER_API_KEY="op://Private/OpenRouter/Saved on openrouter.ai/Marimo"
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
