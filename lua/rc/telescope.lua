return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<leader>f", function() builtin.find_files() end)
        vim.keymap.set("n", "<leader>n", function() builtin.find_files({ cwd = "~/.config/nvim" }) end)
        vim.keymap.set("n", "<leader>c", function() builtin.find_files({ cwd = "~/.config" }) end)
        vim.keymap.set("n", "<leader>g", function() builtin.git_files() end)
        vim.keymap.set("n", "<leader>r", function() builtin.live_grep() end)

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-c>"] = require('telescope.actions').close,
                        ["<C-u>"] = false,
                    },
                    n = {
                        ["<C-c>"] = require('telescope.actions').close,
                    }
                }
            }
        })
    end
}
