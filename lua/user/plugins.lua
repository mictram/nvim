local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- ctags
  use "ludovicchabant/vim-gutentags"

  -- colorschemes
  use {'tiagovla/tokyodark.nvim' }
  use { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  use { "zootedb0t/citruszest.nvim" }

  -- nvim-tree and required icons plugin
  use {
          'kyazdani42/nvim-tree.lua',
          requires = {
        	  'kyazdani42/nvim-web-devicons' -- optional, for file icons
          }
  }

  -- bufferline - A snazzy buffer line (with tabpage integration) for Neovim built using lua.
  use {
	  'akinsho/bufferline.nvim',
	  requires = 'nvim-tree/nvim-web-devicons'
  }

  -- telescope
  use {
	  'nvim-telescope/telescope.nvim',
	  requires = {
		  'nvim-lua/plenary.nvim'
	  }
  }

  use {
	  'nvim-lualine/lualine.nvim',
	  requires = {
		  'kyazdani42/nvim-web-devicons',
		  opt = true
	  }
  }
 
  -- auto-resize splits
  use "beauwilliams/focus.nvim"

  -- Treesitter configurations and abstraction layer for Neovim.
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- adds indentation guides to Neovim
  use "lukas-reineke/indent-blankline.nvim"


  -- This script defines motions similar to w, b, e which do not move word-wise (forward/backward), but Camel-wise; i.e. to word boundaries and uppercase letters.
  use 'bkad/CamelCaseMotion'

  -- Distraction-free writing in Vim.
  use "junegunn/goyo.vim"


  -- lsp and completer
  use {
	  -- lspconfig
	  "neovim/nvim-lspconfig",
	  "williamboman/mason.nvim",

	  -- cmp
	  "hrsh7th/cmp-nvim-lsp",
	  "hrsh7th/cmp-buffer",
	  "hrsh7th/cmp-path",
	  "hrsh7th/cmp-cmdline",
	  "hrsh7th/nvim-cmp",

	  -- vsnip
	  "hrsh7th/cmp-vsnip",
	  "hrsh7th/vim-vsnip",

	  -- lspkind for completion menu pictograms
	  "onsails/lspkind.nvim",
  }

  use {
  	"folke/trouble.nvim",
        version = '3.6.0',
  	requires = "kyazdani42/nvim-web-devicons"
  }

  use {
	  "iamcco/markdown-preview.nvim",
	  run = "cd app && npm install",
	  setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
	  ft = { "markdown" }
  }

  use {
	  'MeanderingProgrammer/render-markdown.nvim',
	  after = { 'nvim-treesitter' },
    	  requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    	  -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    	  -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    	  config = function()
    	      require('render-markdown').setup({})
    	  end,
  }

  use { "nanozuki/tabby.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
