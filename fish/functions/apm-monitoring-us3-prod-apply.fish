# Configuration for terraform dashboards
function apm-monitoring-us3-prod-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/us3.prod.dog/apm-monitoring"
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_US3_PROD" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_US3_PROD" DATADOG_HOST="$DD_APM_MONITORING_HOST_US3_PROD" aws-vault exec prod-engineering -- make apply
  popd
end

