function! TrimWhite()
  let view = winsaveview()
  silent! %s/\s\+$//e
  silent! g/^[\n\s]*\%$/d
  call winrestview(view)
endfunction
