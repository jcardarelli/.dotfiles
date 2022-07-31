-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- https://github.com/wbthomason/packer.nvim/issues/243#issuecomment-789792895
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Neovim LSP setup
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Colorscheme
  -- use 'shaunsingh/seoul256.nvim'
  -- use 'marko-cerovac/material.nvim'
  -- use {
  --     "mcchrish/zenbones.nvim",
  --     -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  --     -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  --     -- In Vim, compat mode is turned on as Lush only works in Neovim.
  --     requires = "rktjmp/lush.nvim"
  -- }
  -- use "EdenEast/nightfox.nvim"
  use({
       "catppuccin/nvim",
       as = "catppuccin"
  })

  -- Lualine
  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = false }
  }

  -- Ultisnips LSP completion
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- Java
  use {
      "mfussenegger/nvim-jdtls",
       ft = { "java" }
  }

  -- Golang
  -- use 'fatih/vim-go'
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- for floating window support

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use{ 'anuvyklack/pretty-fold.nvim',
    requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
    config = function()
       require('pretty-fold').setup()
       require('pretty-fold.preview').setup()
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- line indent markers
  use "lukas-reineke/indent-blankline.nvim"

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
