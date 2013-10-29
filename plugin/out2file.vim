function! s:EmitRangeToFile(file) range abort
  let sourceWin = winnr() + 1
  let size = min([winheight(0) / 2, abs(a:lastline - a:firstline) + 4])

  execute a:firstline ."," . a:lastline . "y"
  execute size . "split" "+0" a:file
  silent put!
  let destWin = winnr()
  execute sourceWin . "wincmd w"
  silent :execute a:firstline . "," . a:lastline . "d"
  execute destWin . "wincmd w"
  execute "normal vgg"
endfunction

function! s:SplitModule()
  call search('^\s*$', 'bcW')
  let insertLine = getpos('.')
  call search('\S', 'bW')

  let bottomLine = line('.')
  normal %

  if(line('.') > bottomLine)
    throw "Bad position"
  endif
  let indent = matchlist(getline("."), '^\(\s*\)\S')[1]

  call search('^\s*\(' . indent . '\)\@<!\S', 'bW')

  let moduleLine = getline('.')
  let moduleIndent = matchlist(getline("."), '^\(\s*\)\S')[1]

  call cursor(insertLine[1], insertLine[2])

  call append(line('.'), moduleLine)
  call append(line('.'), "")
  call append(line('.'), moduleIndent . "end")
  normal dd
  normal j
endfunction

command! -nargs=1 -complete=file -range -bar SnipToFile <line1>,<line2>call s:EmitRangeToFile(<f-args>)

command! SplitMod :call s:SplitModule()

vmap <Leader>E :SnipToFile<Space>
nmap <Leader>S :SplitMod<CR>
