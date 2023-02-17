vim.api.nvim_create_autocmd( "BufWritePre", {
  pattern = "*.tex",
  callback = function()
    vim.cmd('silent! execute "%s/、/, /g"')
    vim.cmd('silent! execute "%s/。/. /g"')
  end,
})
