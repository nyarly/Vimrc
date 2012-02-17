function! ToggleFolding()
  if &foldcolumn == 0
    set foldcolumn=4
  else
    set foldcolumn=0
  endif

  if &foldenable
    set nofoldenable
    let b:toggle_foldmethod = &foldmethod
    setlocal foldmethod=manual
  else
    set foldenable
    if exists("b:toggle_foldmethod")
      exec "setlocal foldmethod=" . b:toggle_foldmethod
    else
      setlocal foldmethod=syntax
    endif
  endif


endfunction

map <F8> :call ToggleFolding()<CR>
