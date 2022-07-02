local vim = vim
vim.cmd [[packadd packer.nvim]]
return require("packer").startup({function()
    local use = use
    use 'wbthomason/packer.nvim'
    use "lukas-reineke/indent-blankline.nvim"
    use 'glepnir/galaxyline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'tpope/vim-surround'
    use 'stevearc/dressing.nvim'
    use "Pocco81/AutoSave.nvim"
    use 'windwp/nvim-ts-autotag'
    use 'windwp/nvim-autopairs'
    use {
      "ray-x/lsp_signature.nvim",
    }
    use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    -- Autocomlplete
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'onsails/lspkind.nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'nvim-treesitter/nvim-treesitter'
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").register_lsp_virtual_lines()
      end,
    })
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
        }
    use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use 'navarasu/onedark.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
end,
config = {
  display = {
	  open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})

