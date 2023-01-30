return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/which-key.nvim",
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local null_ls = require("null-ls")

          null_ls.setup({
            sources = {
              null_ls.builtins.formatting.stylua,
              null_ls.builtins.diagnostics.eslint,
            },
          })
        end,
      },
    },

    config = function()
      require("mason").setup()
      require("fidget").setup()

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n",  "K", vim.lsp.buf.hover,           opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references,      opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition,      opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation,  opts)
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help,  opts)
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action,     opts)
      vim.keymap.set("n", "ge", vim.diagnostic.open_float,   opts)

      local wk = require("which-key")
      wk.register({
            ["<leader>a"] = { vim.lsp.buf.format,     "Format" },
            ["<leader>r"] = { vim.lsp.buf.rename,     "Rename" },
            ["<leader>j"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
            ["<leader>k"] = { vim.diagnostic.goto_next,  "Next diagnostic" },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })
    end,
  },
}