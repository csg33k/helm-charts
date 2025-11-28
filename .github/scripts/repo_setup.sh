#!/usr/bin/env bash
set -e

echo "Adding Helm repositories..."
# Add more repos here as needed
echo "Updating Helm repositories..."
helm repo update || echo "Failed to update helm repos"

echo "Helm repositories configured successfully"
