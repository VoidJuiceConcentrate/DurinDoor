#!/bin/bash

echo "Creating and setting permissions for the input/output folders"
mkdir -p $HOME/buildrootInput
sudo chown -R 999:999 $HOME/buildrootInput
mkdir -p $HOME/buildrootOutput
sudo chown -R 999:999 $HOME/buildrootOutput

echo "Building and running instance of Printer"
docker compose -f docker-compose-main.yml up -d

echo "Printer ready for Printing."
