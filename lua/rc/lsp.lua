return {
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            -- options
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewfile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "folke/which-key.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    if (server_name == "lua_ls") then
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { 'vim' }
                                    },
                                    format = {
                                        enable = true,
                                        defaultConfig = {
                                            indent_style = "space",
                                            indent_size = "2",
                                        },
                                    },
                                }
                            }
                        }
                    elseif (server_name == "texlab") then
                        -- go to last loc when opening a buffer
                        -- vim.api.nvim_create_autocmd({ "BufNewfile", "BufReadPre" }, {
                        --   pattern = "*.tex",
                        --   callback = function()
                        --     if vim.fn.executable('tectonic') then
                        -- local pdf_cmd = ""
                        -- local pdf_args = {}
                        -- if vim.loop.os_uname().sysname == "Darwin" then
                        -- pdf_cmd = "displayline"
                        -- pdf_args = { "%l", "%p", "%f" }
                        -- end
                        --       else
                        --         pdf_cmd = "zathura"
                        --         pdf_args = { "--synctex-forward", "%l:0:%f", "%p" }
                        --       end
                        lspconfig.texlab.setup({
                            settings = {
                                texlab = {
                                    rootDirectory = nil,
                                    build = {
                                        executable = 'tectonic',
                                        -- args = { "-X", "compile", "--synctex", "%f", "--keep-logs", "--keep-intermediates", "-Z", "search-path=~/.tex" },
                                        -- args = { "-k", "-Z", 'search-path=$TEXINPUTS', "%f" },
                                        args = { "-k", "-Z", 'search-path=/Users/obi/.tex', "%f" },
                                        onSave = true,
                                        forwardSearchAfter = false,
                                    },
                                    auxDirectory = '.',
                                    forwardSearch = {
                                        executable = "displayline",
                                        args = { "%l", "%p", "%f" },
                                    },
                                    chktex = {
                                        onOpenAndSave = false,
                                        onEdit = false,
                                    },
                                    diagnosticsDelay = 300,
                                    -- latexFormatter = 'latexindent',
                                    -- latexindent = {
                                    --     ['local'] = nil, -- local is a reserved keyword
                                    --     modifyLineBreaks = false,
                                    -- },
                                    bibtexFormatter = 'texlab',
                                    formatterLineLength = 80,
                                },
                            },
                        })
                    else
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end
                end,
            })
        end,
    },
}
