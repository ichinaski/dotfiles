function vv
  if count $argv > /dev/null
    set result (fzf -m -q $argv)
  else
    set result (fzf -m)
  end
  if [ -n "$result" ]
    v $result
  end
end
