#!/bin/bash

echo "Running deploy"

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/deploy_key # Allow read access to the private key
ssh-add .travis/deploy_key # Add the private key to SSH



# Skip this command if you don't need to execute any additional commands after deploying.
ssh -o StrictHostKeyChecking=no koralbuild@$IP -p $PORT <<EOF
  cd $DEPLOY_DIR
  
  if [ ! -d $DEPLOY_DIR ]; then
    # clone the repo on to the server
    echo "Cloning repo from github"
    git clone $REPO $DEPLOY_DIR
    cd $LIVE_DIR
  else
    # pull changes
    echo "Pulling changes from github"
    cd $LIVE_DIR
    git pull
  fi
  
  npm install
  npm update
  pm2 restart bkoralio-server.js
EOF