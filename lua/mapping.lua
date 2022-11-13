local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- Normal =============================================================
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
--keymap("n", ":", ";", opts)
--keymap("n", ";", ":", opts)
keymap("n", "<Leader>j", "<Cmd>bprev<Cr>", opts)
keymap("n", "<Leader>k", "<Cmd>bnext<Cr>", opts)
keymap("n", "<Leader>e", "<Cmd>E<Cr>", opts)
keymap("n", "<Leader>d", "<Cmd>bwipe<Cr>", opts)
keymap("n", "<Esc><Esc>", "<Cmd>noh<Cr>", opts)

-- Insert ==============================================================
--edit
keymap("i", "<C-k>", "<C-o>D", { noremap=true }) -- カーソルから右を全て削除
keymap("i", "<C-j>", "<C-o>o", { noremap=true }) -- 改行
keymap("i", "<C-y>", "<C-o>p", { noremap=true }) -- paste

keymap("i", "<C-a>", "<home>", { noremap=true })
keymap("i", "<C-e>", "<End>", { noremap=true })
keymap("i", "<C-p>", "<Up>", { noremap=true })
keymap("i", "<C-n>", "<Down>", { noremap=true })
keymap("i", "<C-b>", "<left>", { noremap=true })
keymap("i", "<C-f>", "<right>", { noremap=true })

-- Visual ==============================================================
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)
