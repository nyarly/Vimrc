function! TrimWhite()
  let view = winsaveview()
  silent! %s/\s\+$//e
  silent! g/^[\n\s]*\%$/d
  call winrestview(view)
endfunction

command! TrimWhite :call TrimWhite()

if !exists("trimwhite_au")
  let trimwhite_au = 1
  autocmd BufWritePre *.erl,*.rb,*.haml,*.js,*.rake,Rakefile* :call TrimWhite()
endif
