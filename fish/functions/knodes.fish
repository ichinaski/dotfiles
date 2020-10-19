# kubernetes wrapper to get nodes for nodegroups
function knodes
  kubectl get nodes -l node-role.kubernetes.io/$argv= --no-headers
end
