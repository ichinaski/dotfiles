# Generic fish configuration.
# Use env.fish for environment-specific configuration

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less
set -x RBENV_SHELL fish

set -x DOCKER_ID_USER ichinaski

# Add homebrew binaries to the path.
set -x PATH /opt/homebrew/bin:/opt/homebrew/sbin $PATH

# Force certain more-secure behaviours from homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 1
set -x HOMEBREW_CASK_OPTS --require-sha
set -x HOMEBREW_DIR /opt/homebrew
set -x HOMEBREW_BIN /opt/homebrew/bin

# Load python shims
status --is-interactive; and pyenv init - fish | source 

# Load ruby shims
status --is-interactive; and rbenv init - fish | source

# Prefer GNU binaries to Macintosh binaries.
set -x PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH

# Add AWS CLI to PATH
set -x PATH /opt/homebrew/opt/awscli@1/bin $PATH

# Add datadog devtools binaries to the PATH
set -x PATH $HOME/dd/devtools/bin $PATH

# Point GOPATH to our go sources
set -x GOPATH $HOME/go

# Add binaries that are go install-ed to PATH
set -x PATH $GOPATH/bin $PATH

# Point DATADOG_ROOT to ~/dd symlink
set -x DATADOG_ROOT $HOME/dd

set -x MOUNT_ALL_GO_SRC 1

# store key in the login keychain instead of aws-vault managing a hidden keychain
set -x AWS_VAULT_KEYCHAIN_NAME login

# tweak session times so you don't have to re-enter passwords every 5min
set -x AWS_ASSUME_ROLE_TTL 1h
set -x AWS_SESSION_TTL 24h

# Helm switch from storing objects in kubernetes configmaps to
# secrets by default, but we still use the old default.
set -x HELM_DRIVER configmap

# Go 1.16+ sets GO111MODULE to off by default with the intention to
# remove it in Go 1.18, which breaks projects using the dep tool.
# https://blog.golang.org/go116-module-changes
set -x GO111MODULE auto
set -x GOPRIVATE github.com/DataDog

# https://datadoghq.atlassian.net/wiki/spaces/ROCKS/pages/2282914002/Go+Wrapper
set -x PKG_CONFIG_PATH /opt/homebrew/opt/openssl@3/lib/pkgconfig
#set -x CGO_CPPFLAGS "-I/opt/homebrew/Cellar/rocksdb@6.20.3/6.20.3/include -I/opt/homebrew/opt/gperftools/include -DCMAKE_EXE_LINKER_FLAG"
set -x CGO_CPPFLAGS "-I/opt/homebrew/Cellar/rocksdb@6.20.3/6.20.3/include -I/opt/homebrew/Cellar/foundationdb-headers@6.2.30/6.2.30/include -I/opt/homebrew/opt/gperftools/include -DCMAKE_EXE_LINKER_FLAG"
set -x CGO_CXXFLAGS_ALLOW "-lpthread|-ltcmalloc"
set -x CGO_CFLAGS_ALLOW "-ltcmalloc"

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
alias ev 'nvim ~/.config/nvim/init.vim'
alias ef 'nvim ~/.config/fish/config.fish'
alias ilog 'vim ~/gdrive/chinaski.log'
alias fh 'fzf-history-widget'
alias ff 'fzf-file-widget'
alias fcd 'fzf-cd-widget'

# Load custom env vars
if test -e ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end

# Vim key bindings
fish_vi_key_bindings

# iterm2 shell intergration, needed for kubernetes contextual info on iterm2_print_user_vars
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

alias av='aws-vault exec sandbox-account-admin --'
alias avk='aws-vault exec sandbox-account-admin -- kubectl'
