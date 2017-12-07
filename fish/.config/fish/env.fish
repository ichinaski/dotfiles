# Environment-specific configuration

#set -x GOROOT /usr/bin/go
set -x GOPATH ~/go
set -x X $GOPATH/src/github.com/opinary/x
set -x GOOGLE_APPLICATION_CREDENTIALS ~/opinary-dev-4f4810d35a04.json 
set -x DOCKER_ID_USER ichinaski

# PATH
set -xg PATH \
  $GOPATH/bin \
  #$GOROOT/bin \
  ~/bin \
  ~/google-cloud-sdk/bin \
  ~/bin/go_appengine \
  ~/bin/protoc-3.0.0-osx-x86_64/bin \
  $PATH

# Python config
set -xg PYTHONPATH \
  ~/opinary/automation:\
  ~/google-cloud-sdk/platform/google_appengine:\

set -x VIRTUALFISH_HOME ~/.venvs
eval (python -m virtualfish)
