host_parameter_name="/github-action-runners/gh-runner/runners/app_instance_host"
deploy_host=$(aws ssm get-parameter --name "$host_parameter_name" --query "Parameter.Value" --output text)
export DEPLOY_HOST="$deploy_host"

user_parameter_name="/github-action-runners/gh-runner/runners/app_instance_user"
deploy_user=$(aws ssm get-parameter --name "$user_parameter_name" --query "Parameter.Value" --output text)
export DEPLOY_USERNAME="$deploy_user"

echo "export DEPLOY_HOST=$DEPLOY_HOST"
echo "export DEPLOY_USERNAME=$DEPLOY_USERNAME"