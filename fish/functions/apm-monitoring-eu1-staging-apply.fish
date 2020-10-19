function apm-monitoring-eu1-staging-apply
  pushd "$DATADOG_ROOT/cloudops/datacenter/eu1.staging.dog/apm-monitoring"
  gcloud config set project datadog-staging
  cloudops-cli modules update
  env DD_API_KEY="$DD_APM_MONITORING_API_KEY_EU1_STAGING" DD_APP_KEY="$DD_APM_MONITORING_APP_KEY_EU1_STAGING" DATADOG_HOST="$DD_APM_MONITORING_HOST_EU1_STAGING" make apply
  popd
end
