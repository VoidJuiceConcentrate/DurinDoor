#!/bin/bash

echo "Creating and setting permissions for the input/output folders"
mkdir -p $HOME/buildrootImages
sudo chown -R 999:999 $HOME/buildrootImages

echo "Building and running instance of Printer"
docker compose -f docker-compose-main.yml up -d

echo "Printer ready for Printing."
