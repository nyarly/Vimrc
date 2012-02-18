function SwapfileAutocmd()
  let decide_ruby = "ruby require '" . findfile("swapfile_parse.rb", &runtimepath) ."'; Vim::Swapfile::Decider.new('" . v:swapname . "').be_blase"
  exec decide_ruby
endf

if !exists("blase_swapfiles_loaded")
  let blase_swapfiles_loaded = 1
  autocmd SwapExists * :call SwapfileAutocmd()
endif
