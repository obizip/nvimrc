return {
	"ryota2357/vim-skim-synctex",
	ft = { "tex" },
	dependencies = {
		"vim-denops/denops.vim",
	},
	config = function()
		vim.cmd([[
      call synctex#option('readingBar', v:true)
      call synctex#option('autoQuit', v:true)

      call synctex#option('readingBar', v:true)

      " fix skim setting(Prefarence > Sync > PDF-Tex Sync support > Arguments)
      "   localhost:6000 -XPUT -d "%line %file"
      call synctex#option('port', 6000)

      " autocmd FileType tex call s:TexKeymap()

      function! s:TexKeymap() abort
        nnoremap <buffer> <Space>s <Cmd>call synctex#forwardSerch()<CR>
        command! -buffer SynctexStart :call synctex#start()
        command! -buffer SynctexStop :call synctex#stop()
      endfunction

    ]])
	end,
}
