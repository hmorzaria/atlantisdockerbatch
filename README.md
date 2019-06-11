# atlantisdockerbatch
## Docker file for atlantis for batch processes
### These isntructions assume you are running Ubuntu 18.04 (Bionic)

### To install docker
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

##### install Docker
sudo apt install -y docker-ce

##### Check that the Docker daemon started
sudo systemctl status docker

##### If daemon returns error then run this command then close server session or SSH session and reconnect/restart
#ps://techoverflow.net/2017/03/01/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket/
sudo usermod -a -G docker $USER

#### Pull an existing image from Dockerhub and run as a new container
sudo docker pull hmorzaria/atlantisdockerbatch

##### Run the container, susbtitute NAME for whatever name you want the image to have on your computer
sudo docker run -it -d --name <NAME> -v $HOME:/home/atlantis hmorzaria/atlantisdockerbatch:latest

##### Show containers, running and not, get Container ID
docker ps -a 

##### Then enter the container from Bash, substitute container ID for result of docker ps command above
docker exec -it <container ID> bash

#### Install Atlantis in the container

##### Get code from CSIRO SVN, if need to change version use -r 6356 for example, substitute USERNAME and PASSWORD for your Confluence username and password

svn co -r 6356 https://svnserv.csiro.au/svn/ext/atlantis/Atlantis/trunk --username <USERNAME> --password <PASSWORD> --quiet

##### Build Atlantis
cd trunk/atlantis; aclocal; autoheader; autoconf; automake -a; ./configure; make CFLAGS='-Wno-misleading-indentation -Wno-format -Wno-implicit-fallthrough'; make -d install

##### Other useful Docker commands
###### To restart existing container
docker start <container ID> 

###### to stop a container
docker stop <containerID> 

