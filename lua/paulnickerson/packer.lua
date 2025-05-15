-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  "loctvl842/monokai-pro.nvim",
	  config = function()
		  require("monokai-pro").setup()
	  end
  }

  -- Hack to get treesitter install working as per https://github.com/nvim-treesitter/nvim-treesitter/issues/5536#issuecomment-1826400562
  require'nvim-treesitter.configs'.setup {
	  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  }
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }

  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

end)
