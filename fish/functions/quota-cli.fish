function quota-cli
  kubectl exec -it (kubens apm-general > /dev/null 2>&1 && kubectl get pods --no-headers -o custom-columns=":metadata.name" -l app=quota-cli) -- bash $argv;
end
