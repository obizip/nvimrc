return {
	"TimUntersberger/neogit",
	keys = { { "<leader>g", "<cmd>Neogit<cr>", desc = "Open neogit" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup()
	end,
}
