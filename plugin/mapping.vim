function! s:NonSpecialMappings()
  noremap <buffer> <F4> :<C-U>CtrlPBuffer<CR>
  inoremap <buffer> <F4> <Esc>:<C-U>CtrlPBuffer<CR>
  nnoremap <buffer> <silent> <CR> i<CR><Esc>
  imap <buffer> <C-L> <Plug>delimitMateJumpMany
  nmap <buffer> <Up> vk
  nmap <buffer> <Down> vj
  nmap <buffer> <Left> <<
  nmap <buffer> <Right> >>

  vmap <buffer> <Up> <ESC>'>gvk
  vmap <buffer> <Down> <ESC>'<gvj
  vmap <buffer> <Left> <gv
  vmap <buffer> <Right> >gv
endfunction

function! s:SetMappings()
  if(! exists("b:mappings_set"))
    let b:mappings_set=1
    if &buftype == ''
      call s:NonSpecialMappings()
    endif
  endif
endfunction

function! ToggleDark()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
  colorscheme solarized
endfunction

nnoremap WW :TrimWhite<CR>:update<CR>
imap <C-W> <Esc>:
imap <C-H> <C-O>h
imap <C-J> <C-O>j
imap <C-K> <C-O>k
noremap <silent><Leader>] <Esc>:nohls<CR>
inoremap jk <Esc>
inoremap jK <Esc>
nnoremap / /\v
vnoremap / /\v
cmap w!! %!sudo tee > /dev/null %
map <F7> :call ToggleDark()<CR>

autocmd BufReadPost,BufNewFile * call s:SetMappings()
