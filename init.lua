vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
--- Options ---
-- Unload -- 
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1
vim.g.did_indent_on             = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_getscript          = 1
vim.g.loaded_getscriptPlugin    = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_logiPat            = 1
vim.g.loaded_logipat            = 1
vim.g.loaded_man                = 1
vim.g.loaded_matchit            = 1
vim.g.loaded_matchparen         = 1
vim.g.loaded_netrw              = 1
vim.g.loaded_netrwFileHandlers  = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_netrwSettings      = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_rrhelper           = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_sql_completion     = 1
vim.g.loaded_tar                = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.loaded_vimball            = 1
vim.g.loaded_vimballPlugin      = 1
vim.g.loaded_zip                = 1
vim.g.loaded_zipPlugin          = 1
vim.g.skip_loading_mswin        = 1
vim.g.vimsyn_embed              = 1
-- Base --
vim.cmd("syntax on")
vim.o.encoding = "utf-8"
vim.o.history = 1000
vim.o.clipboard = "unnamedplus"
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.backspace = "indent,eol,start"
vim.o.virtualedit = "block"
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加
vim.o.completeopt = "menuone,noselect,noinsert"

-- File --
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undo'
-- Display --
vim.o.title = true
vim.o.termguicolors = true
vim.o.number = false
vim.o.cmdheight = 0
vim.o.showmode = false
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.showcmd = false
vim.o.laststatus = 1
vim.o.wildmenu = true
vim.o.wildmode = "list:longest,full"
-- Tab & Indent -- 
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 0
vim.o.expandtab = true -- expand tab to spaces
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "+ "
vim.o.breakindent = true
-- Search --
vim.o.wrapscan = true -- 最後まで検索したら先頭へ戻る
vim.o.ignorecase = true -- 大文字小文字無視
vim.o.smartcase = true -- 大文字ではじめたら大文字小文字無視しない
vim.o.incsearch = true -- インクリメンタルサーチ
vim.o.hlsearch = true -- 検索文字をハイライト

--- Plugins ---
--install packer 
--https://github.com/wbthomason/packer.nvim
--
vim.cmd ([[packadd packer.nvim]])

require('packer').startup(function(use) 
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'EdenEast/nightfox.nvim'
    use 'lambdalisue/fern.vim'
    use 'lambdalisue/fern-hijack.vim'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
    }
end)

-- Plugin setting
require'nvim-treesitter.configs'.setup ({
    highlight = {
        enable = true,
        disable = {},
    },
})
vim.cmd("colorscheme duskfox")
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
--- Commands ---
vim.cmd ([[
    command! -count=4 Tab call SetTab(<count>)
    function! SetTab(count)
        execute 'set shiftwidth=' . a:count
        execute 'set tabstop=' . a:count
    endfunction
]])
--- Mappings --- 
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
-- Normal mode -- 
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)
vim.keymap.set("n", "<Esc><Esc>", ":noh<Cr>", opts)
vim.keymap.set("n", "<Leader>j", ":bprev<Cr>", opts)
vim.keymap.set("n", "<Leader>k", ":bnext<Cr>", opts)
vim.keymap.set("n", "<Leader>s", ":wall<Cr>", opts)
vim.keymap.set("n", "<Leader>e", ":e %:h<Cr>", opts)
vim.keymap.set("n", "<Leader>d", ":bwipe<Cr>", opts)
vim.keymap.set("n", "<Leader>c", ":e $MYVIMRC<Cr>", opts)
vim.keymap.set("n", "<Leader>r", ":source $MYVIMRC<Cr>", opts)
vim.keymap.set("n", "<Leader>n", ":set number<Cr>", opts)
vim.keymap.set("n", "<Leader>N", ":set nonumber<Cr>", opts)
vim.keymap.set("n", "<Leader>2", ":Tab 2<Cr>", opts)
vim.keymap.set("n", "<Leader>4", ":Tab 4<Cr>", opts)
vim.keymap.set('n', 'K',  ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', ':lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', ':lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', ':lua vim.diagnostic.goto_prev()<CR>')
-- Insert mode -- 
vim.keymap.set("i", "<C-k>", "<C-o>D", { noremap=true }) -- カーソルから右を全て削除
vim.keymap.set("i", "<C-j>", "<C-o>o", { noremap=true }) -- 改行
vim.keymap.set("i", "<C-y>", "<C-o>p", { noremap=true }) -- paste
vim.keymap.set("i", "<C-b>", "<left>", { noremap=true })
vim.keymap.set("i", "<C-f>", "<right>", { noremap=true })
vim.keymap.set("i", "{",        "{}<Left>",               opts)
vim.keymap.set("i", "{<Enter>", "{}<Left><CR><ESC><S-o>", opts)
vim.keymap.set("i", "(",        "()<ESC>i",               opts)
vim.keymap.set("i", "(<Enter>", "()<Left><CR><ESC><S-o>", opts)
-- Visual mode -- 
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
-- Command mode -- 
vim.keymap.set("c", "<C-b>", "<left>", { noremap=true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap=true })
