function! ToggleDark()
  if &background == "dark"
    setlocal background=light
  else
    setlocal background=dark
  endif
endfunction

map <F7> :call ToggleDark()<CR>
