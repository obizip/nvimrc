return {
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme duskfox]])
  --   end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          show_buffer_close_icon = false,
          always_show_bufferline = false,
          show_buffer_icons = true,
          show_buffer_default_icon = false,
          buffer_close_icon = "",
          separator_style = "thin",
          diagnostics_indicator = function(_, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon
          end,
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local custom_nightfly = require("lualine.themes.nightfly")
      local bg = "#1a1b26"
      local fg = "#a9b1d6"

      custom_nightfly.replace.b.fg = fg
      custom_nightfly.replace.b.bg = bg

      custom_nightfly.normal.b.fg = fg
      custom_nightfly.normal.b.bg = bg
      custom_nightfly.normal.c.fg = fg
      custom_nightfly.normal.c.bg = bg

      custom_nightfly.inactive.b.fg = fg
      custom_nightfly.inactive.b.bg = bg
      custom_nightfly.inactive.c.fg = fg
      custom_nightfly.inactive.c.bg = bg

      custom_nightfly.visual.b.fg = fg
      custom_nightfly.visual.b.bg = bg

      custom_nightfly.insert.b.fg = fg
      custom_nightfly.insert.b.bg = bg
      -- background: '0x1a1b26'
      -- foreground: '0xa9b1d6'

      require("lualine").setup({
        options = {
          theme = custom_nightfly,
        },
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = {
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
      },
      char = "▏",
      use_treesitter_scope = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
    },
  },
}
