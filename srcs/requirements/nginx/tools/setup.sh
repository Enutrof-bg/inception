#!/bin/bash

echo "Nginx: init script running"

while ! nc -z wordpress 9000; do
  echo "Waiting for Nginx to be available..."
  sleep 2
done

echo "Nginx is available, starting setup script"
exec nginx -g "daemon off;"
