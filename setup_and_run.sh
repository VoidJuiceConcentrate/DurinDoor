#!/bin/bash

echo "Creating and setting permissions for the MySQL data directory..."
mkdir -p $HOME/Shinobi
sudo chown -R 999:999 $HOME/Shinobi

echo "Building the Docker image for ShinobiNodePrinter5"
 docker compose build -f docker-compose-main.yml up

echo "Running instance of Printer"
docker compose -f docker-compose-main.yml up -d

echo "Printer ready for Printing."
