local M = {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	dependencies = {
		"HiPhish/nvim-ts-rainbow2",
		"windwp/nvim-ts-autotag",
		"andymass/vim-matchup",
	},
}

function M.config()
	-- require("orgmode").setup_ts_grammar()

	require("nvim-treesitter.configs").setup({
		-- ensure_installed = { "org" },
		autotag = {
			enable = true,
		},
		highlight = {
			enable = true,
			disable = {},
			-- additional_vim_regax_highlighting = { "org" },
		},
		rainbow = {
			enable = true,
			-- list of languages you want to disable the plugin for
			disable = { "jsx" },
			-- Which query to use for finding delimiters
			query = "rainbow-parens",
			-- Highlight the entire buffer all at once
			strategy = require("ts-rainbow.strategy.global"),
			-- Do not enable for files with more than n lines
			max_file_lines = 3000,
		},
		matchup = {
			enable = true,
		},
	})
end

return M
