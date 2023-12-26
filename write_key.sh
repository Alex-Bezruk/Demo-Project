#!/bin/bash

# Step 1: Get parameter value from AWS SSM
parameter_name="/github-action-runners/gh-runner/runners/app_instance_key"
aws_ssm_key_value=$(aws ssm get-parameter --name "$parameter_name" --query "Parameter.Value" --output text)

if [ -z "$aws_ssm_key_value" ]; then
    echo "Error: Unable to retrieve parameter value from AWS SSM."
    exit 1
fi

# Step 2: Decode base64 value
decoded_value=$(echo "$aws_ssm_key_value" | base64 -d)

[ -e key.pem ] && rm key.pem
# Step 3: Write decoded value to key.pem file
echo "$decoded_value" > key.pem

echo "Decoded value has been written to key.pem."


host_parameter_name="/github-action-runners/gh-runner/runners/app_instance_host"
deploy_host=$(aws ssm get-parameter --name "$host_parameter_name" --query "Parameter.Value" --output text)
export DEPLOY_HOST="$deploy_host"

user_parameter_name="/github-action-runners/gh-runner/runners/app_instance_user"
deploy_user=$(aws ssm get-parameter --name "$user_parameter_name" --query "Parameter.Value" --output text)
export DEPLOY_USERNAME="$deploy_user"

echo "DEPLOY_HOST has been set to: $DEPLOY_HOST"
echo "DEPLOY_USER has been set to: $DEPLOY_USERNAME"