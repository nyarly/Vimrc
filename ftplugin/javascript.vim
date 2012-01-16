set sw=2
set ts=2

if !exists("javascript_trimwhite_au")
  let javascript_trimwhite_au = 1
  autocmd BufWritePre *.js :call TrimWhite()
endif

let javaScript_fold = 1
set foldmethod=syntax
set nofoldenable
set foldlevel=2
