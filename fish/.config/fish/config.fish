# Generic fish configuration.
# Use env.fish for environment-specific configuration

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# nice light cyan color instead of dark blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

set -x EDITOR vim
set -x VISUAL vim
set -x PAGER less

# Fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set -x fish_greeting ''

# Aliases
alias l='ls -lFh'
alias ll='ls -alF'
alias vi=vim
alias workon='vf activate'
alias deactivate='vf deactivate'

if test -e ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end
