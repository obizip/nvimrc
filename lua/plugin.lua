vim.cmd([[packadd packer.nvim]])

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim' -- optimiser 
    use "EdenEast/nightfox.nvim" -- Packer
    -- Display
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use { 'feline-nvim/feline.nvim', branch = '0.5-compat' }
    use { 'lewis6991/gitsigns.nvim' }
    use({
      "folke/noice.nvim",
      config = function()
        require("noice").setup()
      end,
      requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
})
    -- Editing
    use 'terrortylor/nvim-comment'
    use 'cohama/lexima.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = 
            require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'tpope/vim-fugitive'
    -- lsp 
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-cmdline"
end)

vim.opt.termguicolors = true
require('impatient')
require('gitsigns').setup()
require('config/feline_theme')
vim.cmd("colorscheme carbonfox")
require("bufferline").setup{}

require('nvim_comment').setup()
require('nvim-treesitter').setup()
require('config/lsp')
require('config/noice')
