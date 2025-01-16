#!/bin/bash

set -e

APP_NAME="safevote"
APP_DIR="/var/www/safevote"
REPO_URL="https://git.com/mosesadelere/safevote.git"
BRANCH="main"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# pull latest code
echo "Starting deployment of ${APP_NAME}..."

if [ ! -d "$APP_DIR" ]; then
  echo "Application directory does not exist. Cloning the repo...."
  git clone -b $BRANCH $REPO_URL $APP_DIR
else
  echo "Pulling the latest changes.."
  cd $APP_DIR
  git reset --hard
  git pull origin $BRANCH
fi

echo "Installing dependencies..."
cd $APP_DIR
if [ -f "package.json" ]; then
  npm install
fi

echo "Restarting the application..."
if command -v pm2 &> /dev/null; then
  pm2 restart $APP_NAME || pm2 start npm --name $APP_NAME --start
else
  echo "PM2 not found, starting with 'npm start'..."
  npm start &
fi

echo "Deployment completed successfully"