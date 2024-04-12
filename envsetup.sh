#!/bin/bash

if [ -d "env" ]; then
    echo "Python virtual environment exists"
else
    echo "Creating Python virtual environment"
    python3 -m venv env || { echo "Failed to create virtual environment"; exit 1; }
fi

echo "Activating Python virtual environment"
source env/bin/activate || { echo "Failed to activate virtual environment"; exit 1; }

echo "Installing dependencies"
pip install -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }

if [ -d "logs" ]; then
    echo "Log folder exists"
else
    echo "Creating log folder"
    mkdir logs || { echo "Failed to create log folder"; exit 1; }
    touch logs/error.log logs/access.log || { echo "Failed to create log files"; exit 1; }
    chmod 755 logs || { echo "Failed to set permissions for log folder"; exit 1; }
    chmod 644 logs/*.log || { echo "Failed to set permissions for log files"; exit 1; }
fi

echo "Environment setup complete"

