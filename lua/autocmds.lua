local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
  callback = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)

            vim.keymap.set("n", "gj", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "gk", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "gf", vim.lsp.buf.format, opts)
            vim.keymap.set("n", "gn", vim.lsp.buf.rename, opts)
  end,
})
