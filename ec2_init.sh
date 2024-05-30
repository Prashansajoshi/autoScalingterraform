#!/bin/bash
sudo apt-get update -y
sudo apt install apache2 -y
sudo systemctl status apache2

# sudo apt install nginx -y