# Configuration for terraform dashboards
function apm-monitoring-eu1-prod-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/eu1.prod.dog/apm-monitoring"
  gcloud config set project datadog-prod
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_EU1_PROD" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_EU1_PROD" DATADOG_HOST="$DD_APM_MONITORING_HOST_EU1_PROD" make apply
  popd
end
