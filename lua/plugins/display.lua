return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme duskfox]])
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

  -- {
  --   "romgrk/barbar.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  --   config = function()
  --     -- Set barbar's options
  --     require("bufferline").setup({
  --       -- Enable/disable animations
  --       animation = false,
  --
  --       -- Enable/disable auto-hiding the tab bar when there is a single buffer
  --       auto_hide = true,
  --
  --       -- Enable/disable current/total tabpages indicator (top right corner)
  --       tabpages = true,
  --
  --       -- Enable/disable close button
  --       closable = false,
  --
  --       -- Enables/disable clickable tabs
  --       --  - left-click: go to buffer
  --       --  - middle-click: delete buffer
  --       clickable = true,
  --
  --       -- Enables / disables diagnostic symbols
  --       diagnostics = {
  --         -- you can use a list
  --         { enabled = true, icon = "ﬀ" }, -- ERROR
  --         { enabled = true }, -- WARN
  --         { enabled = false }, -- INFO
  --         { enabled = false }, -- HINT
  --
  --         -- OR `vim.diagnostic.severity`
  --         -- [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
  --         -- [vim.diagnostic.severity.WARN] = { enabled = true },
  --         -- [vim.diagnostic.severity.INFO] = { enabled = false },
  --         -- [vim.diagnostic.severity.HINT] = { enabled = false },
  --       },
  --
  --       -- Disable highlighting alternate buffers
  --       highlight_alternate = false,
  --
  --       -- Disable highlighting file icons in inactive buffers
  --       highlight_inactive_file_icons = false,
  --
  --       -- Enable highlighting visible buffers
  --       highlight_visible = fal
  --       se,
  --
  --       -- Excludes buffers from the tabline
  --       exclude_ft = { "javascript" },
  --       exclude_name = { "package.json" },
  --       -- Sets the maximum padding width with which to surround each tab
  --       maximum_padding = 1,
  --
  --       -- Sets the minimum padding width with which to surround each tab
  --       minimum_padding = 1,
  --
  --       -- Sets the maximum buffer name length.
  --       maximum_length = 15,
  --       -- If set, the letters for each buffer in buffer-pick mode will be
  --       -- assigned based on their name. Otherwise or in case all letters are
  --       -- already assigned, the behavior is to assign letters in order of
  --       -- usability (see order below)
  --       semantic_letters = true,
  --
  --       -- New buffer letters are assigned in this order. This order is
  --       -- optimal for the qwerty keyboard layout but might need adjustement
  --       -- for other layouts.
  --       letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
  --
  --       -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  --       -- where X is the buffer number. But only a static string is accepted here.
  --       no_name_title = nil,
  --     })
  --   end,
  -- },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
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
      use_treesitter_scope = false,
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
