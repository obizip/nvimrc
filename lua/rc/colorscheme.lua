return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- lazy = false,
        -- priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "cocopon/iceberg.vim",
        -- lazy = false,
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme iceberg]])
        end,

    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                on_highlights = function(hl, c)
                    hl.EndOfBuffer = {
                        fg = c.fg_gutter
                    }
                    -- because colorscheme overwrites cursor color in my foot terminal
                    -- hl.Cursor = {fg = c.none, bg = c.none}
                    -- hl.lCursor = {fg = c.none, bg = c.none}
                    -- hl.CursorIM = {fg = c.none, bg = c.none}
                end
            })

            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    {
        "EdenEast/nightfox.nvim",
        -- lazy = false,
        -- priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                    terminal_colors = true,
                },
                palettes = {
                    carbonfox = {
                        bg1 = "#000000",
                        fg1 = "#ffffff",
                        -- sel0 = "#3e4a5b", -- Popup bg, visual selection bg
                        sel0 = "#330033", -- Popup bg, visual selection bg
                        sel1 = "#4d004d", -- Popup sel bg, search bg
                    }
                },

                groups = {
                    all = {
                        -- EndOfBuffer = { fg = "fg3" },
                        EndOfBuffer = { link = "Comment" },
                    }
                }
                -- on_highlights = function(hl, c)
                --     hl.EndOfBuffer = {
                --         fg = c.fg_gutter
                --     }
                -- end
            })

            -- load the colorscheme here
            vim.cmd([[colorscheme carbonfox]])
        end,
    }
}
