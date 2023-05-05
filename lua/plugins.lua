-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'nvim-treesitter/nvim-treesitter'
  use 'wbthomason/packer.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'max397574/better-escape.nvim'
  use 'akinsho/bufferline.nvim'

  -- Theme
  use 'shaunsingh/nord.nvim'
  use 'sainnhe/everforest'
  use 'sainnhe/gruvbox-material'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use "ray-x/lsp_signature.nvim"
  use 'williamboman/mason.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/cmp-dap'

  -- CMP
  use 'onsails/lspkind.nvim'
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", 
      "hrsh7th/cmp-nvim-lsp",
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'octaltree/cmp-look', 
      'hrsh7th/cmp-path', 
      'f3fora/cmp-spell', 
      'hrsh7th/cmp-emoji'
    }
  }

  -- Telescope
  use 'nvim-lua/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim' 

  --Miscellaneous --
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'tpope/vim-commentary' 
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })

end)
