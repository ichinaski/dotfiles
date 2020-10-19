# kubernetes context on menu bar
function iterm2_print_user_vars
  iterm2_set_user_var kubestatus (echo (kubectx -c) "|" (kubens -c))
end
