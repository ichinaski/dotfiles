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

# Disable virtualenv prompt. Everything is handled in fish_prompt function
set -x VIRTUAL_ENV_DISABLE_PROMPT true

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

# Abbreviations
abbr --add tsme 'cd ~/dd/dd-go/trace/apps/trace-spans-meta-extractor'
abbr --add tut 'cd ~/dd/dd-go/trace/apps/trace-usage-tracker'
abbr --add cdagent 'cd ~/dd/datadog-agent'

abbr --add rgf 'rg --files | rg'
abbr --add df 'df -H'

abbr --add g git
abbr --add gp "git push"
abbr --add gl "git pull"
abbr --add gs "git status"
abbr --add ga "git add"
abbr --add gaa 'git add --all'
abbr --add gb "git branch"
abbr --add gc "git commit"
abbr --add gcm --set-cursor "git commit -m '%'"
abbr --add gd "git diff"
abbr --add gco "git checkout"
abbr --add gm "git merge"
abbr --add glg "git log"
# Create git branch prefixed with github username
abbr --add gcb --set-cursor 'git checkout -b "ichinaski/%"'

abbr --add ddpr dd-pr

abbr --add k kubectl
abbr --add pods 'kubectl get pods'
abbr --add deployments 'kubectl get deployments'

abbr --add v nvim
abbr --add ev "nvim ~/.config/nvim/init.vim"
abbr --add ef "nvim ~/.config/fish/config.fish"
abbr --add sf 'source ~/.config/fish/config.fish'

abbr --add fh "fzf-history-widget"
abbr --add ff "fzf-file-widget"
abbr --add fcd "fzf-cd-widget"

# Load custom env vars
if test -e ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end

if test -e "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

# Vim key bindings
fish_vi_key_bindings

# iterm2 shell intergration, needed for kubernetes contextual info on iterm2_print_user_vars
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

alias av "aws-vault exec sandbox-account-admin --"
alias avk "aws-vault exec sandbox-account-admin -- kubectl"
