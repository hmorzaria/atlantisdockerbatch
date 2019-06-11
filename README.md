# atlantisdockerbatch
## Docker for Atlantis
### This Docker provides a base container that has the libraries and dependencies needed to run R and Atlantis
#### Docker can be installed directly on Linux. Windows and MacOS users will need VirtualBox https://www.virtualbox.org/. 
#### These instructions assume you are running Ubuntu 18.04 (Bionic) as an OS.

### To install Docker
##### Install a few prerequisite packages which let apt use packages over HTTPS:
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

##### Add the GPG key for the official Docker repository to your system:
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

##### Add the Docker repository to APT sources:
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

##### Update the package database with the Docker packages from the newly added repo:
    sudo apt update

##### Install from the Docker repo instead of the default Ubuntu repo:
    apt-cache policy docker-ce

##### Install Docker
    sudo apt install -y docker-ce

##### Check that the Docker daemon started
    sudo systemctl status docker

##### If daemon returns error then run this command then close server session or SSH session and reconnect/restart
    ps://techoverflow.net/2017/03/01/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket/
    sudo usermod -a -G docker $USER

#### Pull an existing image from Dockerhub and run as a new container
    sudo docker pull hmorzaria/atlantisdockerbatch

##### Run the container, susbtitute NAME for whatever name you want the container to have
    sudo docker run -it -d --name <NAME> -v $HOME:/home/atlantis hmorzaria/atlantisdockerbatch:latest

##### Show containers, running and not, get Container ID
    docker ps -a 

##### Then enter the container from Bash, substitute container ID for result of docker ps command above
    docker exec -it <container ID> bash

#### Install Atlantis in the container

##### Get code from CSIRO SVN, if need to change version use -r 6356 for example, substitute USERNAME and PASSWORD for your Confluence username and password

    svn co -r 6356 https://svnserv.csiro.au/svn/ext/atlantis/Atlantis/trunk --username <USERNAME> --password <PASSWORD> --quiet

#### Build Atlantis
    cd trunk/atlantis; aclocal; autoheader; autoconf; automake -a; ./configure; make CFLAGS='-Wno-misleading-indentation -Wno-format -Wno-implicit-fallthrough'; make -d install    
    
#### Run Atlantis
##### You can try running the SETAS model example that installs with Atlantis to test the container
    cd /trunk/example

##### Copy here the contents of the bat file
    nano runsetasNew.sh

##### Run
flip -uv *; chmod +x runsetasNew.sh; sh ./runsetasNew.sh

##### Some useful Docker commands
###### To restart existing container
    docker start <container ID> 

###### to stop a container
    docker stop <containerID> 
    
###### to list images
    docker images 

