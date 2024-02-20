#!/bin/bash

# rm & rmi
figlet remove all
sudo docker stop $(sudo docker ps -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi $(sudo docker images -q)
sudo docker network rm lb

figlet build
sudo docker build -t blog-a -f docker/blog-a/Dockerfile docker/blog-a
sudo docker build -t blog-b -f docker/blog-b/Dockerfile docker/blog-b
sudo docker build -t lb -f docker/lb/Dockerfile docker/lb

sudo docker network create lb

figlet run
sudo docker run -d --name blog-a-1 -p 8001:80 --network lb blog-a
sudo docker run -d --name blog-b-1 -p 8002:80 --network lb blog-b
sudo docker run -d --name lb-1 -p 8000:80 --network lb lb

figlet ps
sudo docker ps

figlet network inspect
sudo docker network inspect lb

sl -aF
