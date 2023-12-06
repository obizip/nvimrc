function inoremap(lhs, rhs) 
    vim.keymap.set({"i"}, lhs, rhs, {noremap=true})
end

function nnoremap(lhs, rhs) 
    vim.keymap.set({"n"}, lhs, rhs, {noremap=true})
end

inoremap("<C-b>", "<left>")
inoremap("<C-f>", "<right>")
inoremap("<C-a>", "<C-o>^")
inoremap("<C-e>", "<end>")
inoremap("<C-y>", "<C-r>+") -- paste

nnoremap("Q", "<nop>")
nnoremap("<C-h>", ":bp<cr>")
nnoremap("<C-l>", ":bn<cr>")
nnoremap("<C-q>", ":bwipe<cr>")
nnoremap("<Esc><Esc>", ":noh<cr>")

vim.api.nvim_create_user_command("Numbertoggle", function()
    vim.wo.number = not vim.wo.number
end, {})

nnoremap("<C-n>", ":<C-u>Numbertoggle<cr>")
