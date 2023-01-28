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
