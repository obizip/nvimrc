vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])
--- Options --------------------------------------------------------------------------
-- Base --
vim.cmd("syntax on")
vim.o.encoding = "utf-8"
vim.o.history = 1000
vim.o.clipboard = "unnamedplus"
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.backspace = "indent,eol,start"
vim.o.virtualedit = "none"
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加
vim.o.completeopt = "menu,menuone,noselect"
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
vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.showcmd = false
vim.o.laststatus = 1
vim.o.wildmenu = true
vim.o.wildmode = "list:longest,full"
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- Tab & Indent -- 
vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- tabstopに従う
vim.o.softtabstop = -1 -- shiftwidthに従う 
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

--- Plugins --------------------------------------------------------------------------
--install packer 
--https://github.com/wbthomason/packer.nvim
vim.cmd ([[packadd packer.nvim]])
require('packer').startup(function(use) 
    use 'wbthomason/packer.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'lambdalisue/fern.vim'
    use 'lambdalisue/fern-hijack.vim'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'ggandor/leap.nvim'
    use 'rhysd/migemo-search.vim'

    -- using packer.nvim
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- LSP Support
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'ray-x/cmp-treesitter'
    -- Snippets
    use 'L3MON4D3/LuaSnip'
    -- Option
    use 'j-hui/fidget.nvim'

    use "lukas-reineke/indent-blankline.nvim"
    use 'p00f/nvim-ts-rainbow'
    use 'lervag/vimtex'
    use 'rust-lang/rust.vim'
end)

-- Plugin setting
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
    map_c_h = true,
})
require('nvim-autopairs').remove_rule("'")
require('nvim-autopairs').remove_rule('"')
require('leap').add_default_mappings()
require("bufferline").setup{
    options = {
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = { '|', '|' },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
    },
}
require'nvim-treesitter.configs'.setup ({
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = {},
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    }
})
vim.cmd("colorscheme duskfox")

-- Lsp setting
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
-- 3. completion (hrsh7th/nvim-cmp)

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    sources = {
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "treesitter" },
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
})

-- cmdline
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "path" },
        { name = "cmdline" },
    },
})
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require"fidget".setup{}

-- indent-blankline
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}
-- Vimtex
vim.cmd ([[
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_view_skim_sync=1
let g:vimtex_view_skim_active=1
let g:vimtex_compiler_method = 'latexmk'
let g:maplocalleader=" "
]])
-- Rust
vim.g.rustfmt_autosave = 1
--- Commands ---
vim.cmd ([[
command! -count=4 Tab call SetTab(<count>)
function! SetTab(count)
execute 'set shiftwidth=' . a:count
execute 'set tabstop=' . a:count
endfunction

command! RemoveWhiteSpace :%s/\s*$// | :noh
]])
vim.cmd ([[
command! Migemo call Migemo()
function! Migemo()
    if hasmapto('\<CR>','c')
        cunmap <expr><CR>
    else
        cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
    endif
endfunction
]])

--- Mappings -------------------------------------------------------------------------- 
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
-- Normal mode -- 
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)
vim.keymap.set("n", "p", "]p", opts)
vim.keymap.set("n", "P", "]P", opts)
vim.keymap.set("n", "Q", "<nop>", opts)
vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)
vim.keymap.set("n", "<C-a>", "<Nop>", opts)
vim.keymap.set("n", "<C-x>", "<Nop>", opts)
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
vim.keymap.set("n", "<Leader>ll", ":VimtexCompile<Cr>", opts)
vim.keymap.set("n", "<Leader>lv", ":VimtexView<Cr>", opts)
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
vim.keymap.set("i", "<C-y>", "<C-o>]p", { noremap=true }) -- paste
vim.keymap.set("i", "<C-b>", "<left>", { noremap=true })
vim.keymap.set("i", "<C-f>", "<right>", { noremap=true })
vim.keymap.set("i", "<C-a>", "<home>", { noremap=true })
vim.keymap.set("i", "<C-e>", "<end>", { noremap=true })
vim.keymap.set("i", "<C-c>", "<ESC>", { noremap=true })

-- Visual mode -- 
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
-- Command mode -- 
vim.keymap.set("c", "<C-b>", "<left>", { noremap=true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap=true })

vim.cmd([[
augroup MyAutoCmd
if executable('pdftotext')
    " PDFファイルを開いた時、text形式に変換してから開く
    autocmd BufRead *.pdf :enew | 0read !pdftotext -layout -nopgbrk "#" -
endif
" 圧縮ファイルとPDFファイルを開いた時、readonlyモードで開き、j/kキーマップを変更
autocmd BufRead *.zip,*.gz,*.bz2,*.xz,*.pdf setlocal readonly nolist
    \| nn <buffer> j <C-E> | nn <buffer> k <C-Y>
augroup END
]])
