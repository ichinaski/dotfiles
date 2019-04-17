# Generic fish configuration.
# Use env.fish for environment-specific configuration

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# nice light cyan color instead of dark blue
# set -gx LSCOLORS gxfxcxdxbxegedabagacad

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

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

alias c clear
alias l 'ls -lFh'
alias ll 'ls -alF'
alias vi nvim
alias v nvim
alias ddpr dd-pr
alias k kubectl
alias pods "kubectl get pods"
alias deployments "kubectl get deployments"
alias ev "v ~/.vimrc"
alias ef 'v ~/.config/fish/config.fish'
alias ilog 'vim ~/gdrive/chinaski.log'
alias rgf "rg --files | rg"
# alias workon='vf activate' # Old setup with virtualfish
# alias deactivate='vf deactivate' # Old setup with virtualfish

alias quota-cli='kubectl exec -it (kubens apm-general > /dev/null 2>&1 && kubectl get pods --no-headers -o custom-columns=":metadata.name" -l app=quota-cli) -- bash'

if test -e ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end

fish_vi_key_bindings

function df --description 'Displays disk free space'
  command df -H $argv
end

# kubernetes context on menu bar
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
function iterm2_print_user_vars
  iterm2_set_user_var kubestatus (echo (kubectx -c) "|" (kubens -c))
end

# kubernetes wrapper to get nodes for nodegroups
function nodes
  kubectl get nodes -l node-role.kubernetes.io/$argv= --no-headers
end

# kubernetes and Go wrappers to port-forward and debug Go apps
function debug
  kubectl port-forward $argv 6060:6060
end

function pprof
  go tool pprof -http=localhost:8083 http://localhost:6060/debug/pprof/$argv
end

# Configuration for terraform dashboards
function apm-monitoring-us1-staging-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/us1.staging.dog/apm-monitoring"
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_US1_STAGING" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_US1_STAGING" DATADOG_HOST="$DD_APM_MONITORING_HOST_US1_STAGING" aws-vault exec staging-engineering -- make apply
  popd
end

function apm-monitoring-us1-prod-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/us1.prod.dog/apm-monitoring"
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_US1_PROD" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_US1_PROD" DATADOG_HOST="$DD_APM_MONITORING_HOST_US1_PROD" aws-vault exec prod-engineering -- make apply
  popd
end

function apm-monitoring-eu1-staging-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/eu1.staging.dog/apm-monitoring"
  gcloud config set project datadog-staging
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_EU1_STAGING" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_EU1_STAGING" DATADOG_HOST="$DD_APM_MONITORING_HOST_EU1_STAGING" make apply
  popd
end

function apm-monitoring-eu1-prod-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/eu1.prod.dog/apm-monitoring"
  gcloud config set project datadog-prod
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_EU1_PROD" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_EU1_PROD" DATADOG_HOST="$DD_APM_MONITORING_HOST_EU1_PROD" make apply
  popd
end

function apm-monitoring-apply
  apm-monitoring-us1-staging-apply
  apm-monitoring-eu1-staging-apply
  apm-monitoring-us1-prod-apply
  apm-monitoring-eu1-prod-apply
end

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

function vrg
  set result (rg $argv)
  if [ -n "$result" ]
    v $result
  end
end

function batf
  set result (fzf)
  if [ -n "$result" ]
    bat $result
  end
end

function branch
 git checkout -b "ichinaski/"$argv
end
