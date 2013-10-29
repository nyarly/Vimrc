function s:SwapfileAutocmd()
  echo findfile("swapfile_parse.rb", &runtimepath)
  let decide_ruby = "ruby require '" . fnamemodify(findfile("swapfile_parse.rb", &runtimepath), ":p") ."'; Vim::Swapfile::Decider.new('" . v:swapname . "').be_blase"
  exec decide_ruby
endf

if !exists("blase_swapfiles_loaded")
  let blase_swapfiles_loaded = 1
  autocmd SwapExists * :call s:SwapfileAutocmd()
endif
