function fish_prompt
  set -l last_status $status

  if set -q VIRTUAL_ENV
      set_color white
      echo -n -s "(" (basename "$VIRTUAL_ENV") ") "
      set_color normal
  end

  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  echo -n (fish_git_prompt)

  set_color normal

  if test "$fish_key_bindings" = "fish_vi_key_bindings"
      switch $fish_bind_mode
          case default
              set_color white
          case insert
              set_color green
          case visual
              set_color magenta
      end
  end

  echo -n '> '
  set_color normal
end
