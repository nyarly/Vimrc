setlocal shiftwidth=2
setlocal ts=2
setlocal formatoptions=croqwal
setlocal expandtab

if !exists("ruby_trimwhite_au")
  let ruby_trimwhite_au = 1
  autocmd BufWritePre *.rb :call TrimWhite()
endif

let b:surround_100 = "do \r end"
let ruby_fold = 1
let ruby_minlines = 150
set foldmethod=syntax
set nofoldenable
set foldlevel=3

