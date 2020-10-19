# kubernetes and Go wrappers to port-forward and debug Go apps
function kdebug
  kubectl port-forward $argv 6060:6060
end
