# Docker-Ubuntu23-XRDP
 
Using:
1) Get the files
$ ```git clone https://github.com/xp5-org/Docker-Ubuntu23-XRDP```

2) build dockerfile 
$ ```cd Docker-Ubuntu23-XRDP```
$ ```sudo docker build ./ -t myimage```

$ ```docker run -it -p 33890:3389 -e USERPASSWORD=1234 -e USERNAME=myuser myimage:latest```