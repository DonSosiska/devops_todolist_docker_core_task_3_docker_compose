#!/bin/bash
# Stop on the first sign of trouble
set -e

apt-get update
apt-get install -y netcat-openbsd

# Check for the db to be ready
echo "Waiting for MySQL..."
while ! nc -z mysql 3306; do
  sleep 0.1
done
echo "MySQL started"
# Start server
echo "Starting server"
python manage.py runserver 0.0.0.0:8080

# Apply database migrations
echo "Applying database migrations"
python manage.py migrate