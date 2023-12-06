return {
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        event = "InsertEnter",
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>" },
        },
        opts = {
            window = {
                backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                width = 120,     -- width of the Zen window
                height = 1,      -- height of the Zen window
            },
        }
    },
    {
        'stevearc/conform.nvim',
        event = "VeryLazy",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            notify_on_error = true,
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                rust = { "rustfmt" },
                ["_"] = { "trim_whitespace" },
                -- Use a sub-list to run only the first available formatter
                -- javascript = { { "prettierd", "prettier" } },
            },
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            -- refer to `configuration to change defaults`
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    -- {
    --     "folke/flash.nvim",
    --     event = "VeryLazy",
    --     ---@type Flash.Config
    --     opts = {
    --         modes = {
    --             char = {
    --                 -- disable default keys
    --                 keys = {},
    --             },
    --         },
    --     },
    --     -- stylua: ignore
    --     keys = {
    --         { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
    --         { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --         -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --         -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --         -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    --     },
    -- }
    {
        'windwp/nvim-autopairs', -- depended nvim-cmp
        event = "InsertEnter",
        opts = {
            map_c_h = true,
        }
    },
}
