{ config, pkgs, lib, ... }:

{
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      mini-pick
      catppuccin-nvim
      nvim-lspconfig

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-python
          p.tree-sitter-rust
          p.tree-sitter-go
        ]));
      }
    ];

    extraLuaConfig = ''
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.winborder = "rounded"

vim.g.mapleader = " "

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require'nvim-treesitter.configs'.setup {
	ensure_installed = {},
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
}

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.lsp.enable({ "gopls" })

vim.cmd.colorscheme "catppuccin"
    '';
  };
}
