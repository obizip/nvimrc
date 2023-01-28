local M = {
  "hrsh7th/nvim-cmp",

  event = "VeryLazy",

  dependencies = {
    'L3MON4D3/LuaSnip',
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    'saadparwaiz1/cmp_luasnip',
    "hrsh7th/cmp-nvim-lsp",
    'hrsh7th/cmp-nvim-lua',
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "dmitmel/cmp-cmdline-history",
    'ray-x/cmp-treesitter',
    -- 'nvim-orgmode/orgmode'
  },
}

function M.config()
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lsp" },
      { name = 'nvim_lsp_signature_help' },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "treesitter" },
      -- { name = "orgmode" },
    }),
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  })

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  })
})
end

return M
