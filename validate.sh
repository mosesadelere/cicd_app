#!/bin/bash

# Validation Script

# Functions
function check_file_exists() {
    local file=$1
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' does not exist."
        exit 1
    else
        echo "File '$file' exists."
    fi
}

function check_env_variable() {
    local var_name=$1
    if [ -z "${!var_name}" ]; then
        echo "Error: Environment variable '$var_name' is not set."
        exit 1
    else
        echo "Environment variable '$var_name' is set to '${!var_name}'."
    fi
}

function validate_port_number() {
    local port=$1
    if [[ "$port" -lt 1 || "$port" -gt 65535 ]]; then
        echo "Error: Port number '$port' is out of range (1-65535)."
        exit 1
    else
        echo "Port number '$port' is valid."
    fi
}

# Main Execution
echo "Starting validation..."

# Validate a file exists
FILE_TO_CHECK="config.yaml"
check_file_exists $FILE_TO_CHECK

# Validate an environment variable is set
ENV_VAR_NAME="APP_ENV"
check_env_variable $ENV_VAR_NAME

# Validate a port number
PORT_NUMBER=8080
validate_port_number $PORT_NUMBER

echo "All validations passed successfully!"
