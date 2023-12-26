return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
        { "<leader>t", "<cmd>NvimTreeToggle<cr>" },
    },
    opts = {
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    }
}
