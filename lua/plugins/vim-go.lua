return {
  "fatih/vim-go",
  ft = { "go" },
  event = "VeryLazy",
  config = function()
    vim.g.go_doc_keywordprg_enabled = 0
    vim.g.go_def_mapping_enabled = 1
    vim.g.go_metalinter_autosave = 0
  end,
}
