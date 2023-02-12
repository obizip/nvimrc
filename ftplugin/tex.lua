vim.cmd([[
 autocmd BufWritePre *.tex :call FixPunctuation()
   function! FixPunctuation() abort
   let l:pos = getpos('.')
   silent! execute ':%s/。/. /g'
   silent! execute ':%s/、/, /g'
   silent! execute ':%s/\\\@<!\s\+$//'
   call setpos('.', l:pos)
 endfunction

 set matchpairs+=（:）,「:」,『:』,【:】,［:］,＜:＞
 command! FixPunctuation call FixPunctuation()
 
 augroup IME
   autocmd!
   autocmd CmdlineLeave /,? :call system(
   \ 'osascript -e "tell application \"System Events\" to key code 102"'
   \ )
 augroup END

 augroup Mouse
   autocmd!
   autocmd FocusGained _ call s:OnFocusGained()
   autocmd FocusLost _ call s:OnFocusLost()
 augroup END

 function! s:OnFocusGained() abort
   autocmd CursorMoved,CursorMovedI,ModeChanged,WinScrolled * ++once call s:EnebleLeftMouse()
   noremap <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
   inoremap <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
 endfunction
 
 function! s:EnebleLeftMouse() abort
   noremap <LeftMouse> <LeftMouse>
   inoremap <LeftMouse> <LeftMouse>
 endfunction
 
 function! s:OnFocusLost() abort
   noremap <LeftMouse> <nop>
   inoremap <LeftMouse> <nop>
 endfunction
]])
