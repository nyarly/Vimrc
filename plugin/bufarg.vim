function! LoadedBufferList()
  let bufnumbers=tabpagebuflist()
  let bufnumbers=filter(bufnumbers, "bufloaded(v:val)")
  let bufnames=map(bufnumbers, "bufname(v:val)")

  return bufnames
endfunction

cabbrev ### `=LoadedBufferList()`
