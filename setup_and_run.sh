#!/bin/bash

echo "Creating and setting permissions for the MySQL data directory..."
mkdir -p $HOME/Shinobi
sudo chown -R 999:999 $HOME/Shinobi

echo "Building the Docker image for Shinobi CCTV..."
# docker compose build -f docker-compose-main.yml up

echo "Running the main Shinobi CCTV system..."
docker compose -f docker-compose-main.yml up -d

echo "Printer ready for Printing."
