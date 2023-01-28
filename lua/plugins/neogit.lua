return {
  "TimUntersberger/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/which-key.nvim",
  },
  config = function()
    local neogit = require("neogit")
    neogit.setup({})

    local wk = require("which-key")
    wk.register({
      ["<leader>g"] = { ":Neogit<cr>", "Open neogit" },
    })
  end,
}
