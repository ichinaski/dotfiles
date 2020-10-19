function fish_prompt
  set -l last_status $status

  if set -q VIRTUAL_ENV
      set_color white
      echo -n -s "(" (basename "$VIRTUAL_ENV") ") "
      set_color normal
  end

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (fish_git_prompt)

  set_color normal
end
