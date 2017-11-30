#!/bin/bash

echo "Running deploy"

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/deploy_key # Allow read access to the private key
ssh-add .travis/deploy_key # Add the private key to SSH



# Skip this command if you don't need to execute any additional commands after deploying.
ssh -o StrictHostKeyChecking=no koralbuild@$IP -p $PORT <<EOF
  cd $DEPLOY_DIR
  
  if [ ! -d "personal-site" ]; then
    # clone the repo on to the server
    echo "Cloning repo from github"
    git clone $REPO
  else
    # pull changes
    echo "Pulling changes from github"
    git pull
  fi

  npm install && pm2 restart bkoralio-server.js
EOF