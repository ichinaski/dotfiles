# Generic fish configuration.
# Use env.fish for environment-specific configuration

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less
set -x RBENV_SHELL fish

set -x DOCKER_ID_USER ichinaski

set -x AWS_ASSUME_ROLE_TTL 1h
set -x AWS_SESSION_TTL 24h
set -x AWS_VAULT_KEYCHAIN_NAME login

set -x HOMEBREW_CASK_OPTS --require-sha
set -x HOMEBREW_NO_INSECURE_REDIRECT 1

set -x MOUNT_ALL_GO_SRC 1

# Fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set -x fish_greeting ''

# Aliases
alias g git
alias gp 'git pull '
alias gs 'git status '
alias ga 'git add '
alias gb 'git branch '
alias gc 'git commit'
alias gd 'git diff'
alias gco 'git checkout '

alias l 'ls -lFh'
alias ll 'ls -alF'
alias ddpr dd-pr
alias k kubectl
alias v nvim
alias ev "v ~/.vimrc"
alias ef 'v ~/.config/fish/config.fish'
alias ilog 'vim ~/gdrive/chinaski.log'

# Load custom env vars
if test -e ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end

# Vim key bindings
fish_vi_key_bindings

# iterm2 sheel intergration, needed for kubernetes contextual info on iterm2_print_user_vars
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# pyenv
status --is-interactive; and source (pyenv init -|psub)
