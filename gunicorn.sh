#!/bin/bash

# Activate the virtual environment
source /var/lib/jenkins/workspace/django-pipeline/env/bin/activate

# Navigate to the Django app directory
cd /var/lib/jenkins/workspace/django-pipeline/app || { echo "Django app directory not found!"; exit 1; }

# Run Django migrations
python3 manage.py makemigrations || { echo "Makemigrations failed!"; exit 1; }
python3 manage.py migrate || { echo "Migration failed!"; exit 1; }

echo "Migrations done successfully."

# Navigate to the directory containing the Gunicorn configuration files
cd /var/lib/jenkins/workspace/django || { echo "Gunicorn configuration directory not found!"; exit 1; }

# Copy Gunicorn configuration files to systemd directory
sudo cp -rf gunicorn.socket /etc/systemd/system/ || { echo "Failed to copy gunicorn.socket"; exit 1; }
sudo cp -rf gunicorn.service /etc/systemd/system/ || { echo "Failed to copy gunicorn.service"; exit 1; }

# Echo the current user and working directory for debugging purposes
echo "Running as user: $USER"
echo "Current working directory: $PWD"

# Reload systemd and start the Gunicorn service
sudo systemctl daemon-reload || { echo "Systemd reload failed!"; exit 1; }
sudo systemctl start gunicorn || { echo "Failed to start Gunicorn!"; exit 1; }
sudo systemctl enable gunicorn || { echo "Failed to enable Gunicorn!"; exit 1; }

echo "Gunicorn has been started."

# Check the status of the Gunicorn service
sudo systemctl status gunicorn

# Restart Gunicorn to ensure the latest version is running
sudo systemctl restart gunicorn || { echo "Failed to restart Gunicorn!"; exit 1; }

echo "Gunicorn has been restarted successfully."
