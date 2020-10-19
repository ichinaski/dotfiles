function rgf --description 'rg file search'
  rg --files | rg $argv;
end
