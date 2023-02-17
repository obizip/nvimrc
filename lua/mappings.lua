local opts = { noremap = true, silent = true }
-- Normal mode --
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)
vim.keymap.set("n", "Q", "<nop>", opts)
vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)
vim.keymap.set("n", "<C-a>", "<Nop>", opts)
vim.keymap.set("n", "<C-x>", "<Nop>", opts)
vim.keymap.set("n", "<Esc><Esc>", ":noh<Cr>", opts)
vim.keymap.set("n", "<C-s>", ":wall<Cr>", opts)
vim.keymap.set("n", "<C-c>", "<ESC>",   { noremap=true })

vim.keymap.set("n", "<C-f>", "<C-d>", opts)
vim.keymap.set("n", "<C-b>", "<C-u>", opts)

vim.keymap.set("n", "<C-h>", ":bp<Cr>", opts)
vim.keymap.set("n", "<C-l>", ":bn<Cr>", opts)
vim.keymap.set("n", "<C-d>", ":bwipe<Cr>", opts)

vim.api.nvim_create_user_command(
  'Numbertoggle',
  function()
    vim.wo.number = not(vim.wo.number)
  end,
  {}
)
vim.keymap.set("n", "<C-n>", ":<C-u>Numbertoggle<cr>", opts)

local wk = require("which-key")
wk.register({
  ["<leader>c"] = {":e $MYVIMRC<Cr>", "Open init.lua"},
  ["<leader>2"] = {":set tabstop=2<Cr>", "Set tab to 2 spaces"},
  ["<leader>4"] = {":set tabstop=4<Cr>", "Set tab to 4 spaces"},
})

-- Insert mode --
vim.keymap.set("i", "<C-k>", "<C-o>D",  { noremap=true }) -- カーソルから右を全て削除
vim.keymap.set("i", "<C-j>", "<C-o>o",  { noremap=true }) -- 改行
vim.keymap.set("i", "<C-y>", "<C-o>P",  { noremap=true }) -- paste
vim.keymap.set("i", "<C-c>", "<ESC>",   { noremap=true })
vim.keymap.set("i", "<C-b>", "<left>",  { noremap=true })
vim.keymap.set("i", "<C-f>", "<right>", { noremap=true })
vim.keymap.set("i", "<C-a>", "<home>",  { noremap=true })
vim.keymap.set("i", "<C-e>", "<end>",   { noremap=true })
vim.keymap.set("i", "<C-p>", "<up>",    { noremap=true })
vim.keymap.set("i", "<C-n>", "<down>",  { noremap=true })

-- Visual mode --
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("v", "+", "<C-a>", opts)
vim.keymap.set("v", "-", "<C-x>", opts)

-- Command mode --
vim.keymap.set("c", "<C-b>", "<left>", { noremap=true })
vim.keymap.set("c", "<C-f>", "<right>", { noremap=true })
vim.keymap.set("i", "<C-a>", "<home>",  { noremap=true })
vim.keymap.set("i", "<C-e>", "<end>",   { noremap=true })
