vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

--let g:tex_conceal=''
--set virtualedit+=block
require("base")
require("option")
require("display")
require("mapping")
require("command")
require("plugin")
