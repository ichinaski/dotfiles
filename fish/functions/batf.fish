function batf
  set result (fzf)
  if [ -n "$result" ]
    bat $result
  end
end
