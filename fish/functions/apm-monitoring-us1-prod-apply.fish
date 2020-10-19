# Configuration for terraform dashboards
function apm-monitoring-us1-prod-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/us1.prod.dog/apm-monitoring"
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_US1_PROD" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_US1_PROD" DATADOG_HOST="$DD_APM_MONITORING_HOST_US1_PROD" aws-vault exec prod-engineering -- make apply
  popd
end
