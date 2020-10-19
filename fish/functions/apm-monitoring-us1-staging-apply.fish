# Configuration for terraform dashboards
function apm-monitoring-us1-staging-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/us1.staging.dog/apm-monitoring"
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_US1_STAGING" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_US1_STAGING" DATADOG_HOST="$DD_APM_MONITORING_HOST_US1_STAGING" aws-vault exec staging-engineering -- make apply
  popd
end
