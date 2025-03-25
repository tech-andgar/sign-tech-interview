#!/bin/bash
set -e

# Script for handling Surge.sh deployments and teardowns
# Usage: 
# - For deployment: ./surge-deploy.sh deploy <pr-number> <token> <login>
# - For teardown: ./surge-deploy.sh teardown <pr-number> <token> <login>

ACTION=$1
PR_NUMBER=$2
SURGE_TOKEN=$3
SURGE_LOGIN=$4

if [ -z "$ACTION" ] || [ -z "$PR_NUMBER" ] || [ -z "$SURGE_TOKEN" ] || [ -z "$SURGE_LOGIN" ]; then
  echo "Error: Missing required parameters"
  echo "Usage:"
  echo "  ./surge-deploy.sh deploy <pr-number> <token> <login>"
  echo "  ./surge-deploy.sh teardown <pr-number> <token> <login>"
  exit 1
fi

# Get repository name from GitHub environment
REPO_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)
if [ -z "$REPO_NAME" ]; then
  echo "Warning: GITHUB_REPOSITORY not found, using 'sign-tech-interview' as fallback"
  REPO_NAME="sign-tech-interview"
fi

# Build the domain name
DOMAIN="pr-${PR_NUMBER}-${REPO_NAME}.surge.sh"
echo "Domain: $DOMAIN"

# Create .netrc file for Surge authentication
echo "Setting up Surge authentication..."
echo "machine surge.surge.sh" > ~/.netrc
echo "login $SURGE_LOGIN" >> ~/.netrc
echo "password $SURGE_TOKEN" >> ~/.netrc
chmod 600 ~/.netrc

# Install Surge globally with pnpm
echo "Installing Surge with pnpm..."
pnpm add --global surge

if [ "$ACTION" == "deploy" ]; then
  echo "Deploying to Surge..."
  
  # Verify dist directory exists and has content
  if [ ! -d "dist" ] || [ -z "$(ls -A dist)" ]; then
    echo "Error: The dist directory does not exist or is empty"
    exit 1
  fi
  
  # Create .surgeignore file
  touch .surgeignore
  
  # Try deployment with multiple methods in case one fails
  echo "Deploying to $DOMAIN using pnpm exec surge..."
  pnpm exec surge ./dist "$DOMAIN" --token "$SURGE_TOKEN"
  
  if [ $? -ne 0 ]; then
    echo "First deployment method failed, trying alternate method..."
    export SURGE_LOGIN="$SURGE_LOGIN"
    export SURGE_TOKEN="$SURGE_TOKEN"
    pnpm add surge
    pnpm exec surge ./dist "$DOMAIN"
  fi
  
  echo "Preview URL: https://$DOMAIN"
  
elif [ "$ACTION" == "teardown" ]; then
  echo "Tearing down Surge deployment..."
  
  # Try teardown with multiple methods in case one fails
  pnpm exec surge teardown "$DOMAIN" --token "$SURGE_TOKEN"
  
  if [ $? -ne 0 ]; then
    echo "First teardown method failed, trying alternate method..."
    export SURGE_LOGIN="$SURGE_LOGIN"
    export SURGE_TOKEN="$SURGE_TOKEN"
    pnpm add surge
    pnpm exec surge teardown "$DOMAIN"
  fi
  
  echo "Deployment at $DOMAIN has been removed"
  
else
  echo "Error: Unknown action '$ACTION'. Must be 'deploy' or 'teardown'."
  exit 1
fi

echo "Surge operation completed." 
