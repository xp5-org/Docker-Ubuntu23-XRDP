# Docker-Ubuntu23-XRDP
 
Using:
git clone https://github.com/xp5-org/Docker-Ubuntu23-XRDP

sudo docker build ./ -t xrdp

docker run -it -p 33890:3389 -e USERPASSWORD=1234 -e USERNAME=myuser xrdp:latest