# cicd_app

# How deployment script works

# Pull Latest code:
  clone the repository if it doesn't exist
  pull the latest changes if the directory already exists.

# Install dependencies:
  install Node.js dependencies, if a 'package.json' file is detected.

# Restart Application:
  Use PM2 (process manager for nodejs) to restart the application.
  if PM2 is not installed, the script starts the application using 'npm start'.

# Usage of deploy.sh
  save the script 'deploy.sh'
  make it executable:
    chmod +x deploy.sh
  run the script:
    ./deploy.sh


# How validation script works

# check file exist

