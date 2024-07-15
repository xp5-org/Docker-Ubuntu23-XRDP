# Docker-Ubuntu23-XRDP
Audio does not work
 
build it using:
1) Get the files
   
$ ```git clone https://github.com/xp5-org/Docker-Ubuntu23-XRDP```

3) build dockerfile
   
$ ```cd Docker-Ubuntu23-XRDP```

$ ```sudo docker build ./ -t myimage```

$ ```docker run -it -p 3389:3389 -e USERPASSWORD=1234 -e USERNAME=myuser myimage:latest```




Or, pull the docker hub image

$ ```docker pull xp5org/ubuntu23-xrdp```

$ ```docker tag xp5org/ubuntu23-xrdp myimage:latest```

$ ```docker run -it -p 3389:3389 -e USERPASSWORD=1234 -e USERNAME=myuser myimage:latest```
