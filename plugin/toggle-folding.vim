function! ToggleFolding()
  if &foldcolumn == 0
    set foldcolumn=4
  else
    set foldcolumn=0
  endif

  set foldenable!
endfunction

map <F8> :call ToggleFolding()<CR>
