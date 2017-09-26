#!/bin/bash
###shell script to build out the zeppelin environment

### Set up system with up to date dependencies
apt-get update -y
apt-get upgrade -y

### install htop
apt-get install htop

### Do the docker install
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install docker-ce -y

docker run hello-world

### Docker compose install
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


### now lets build the django env
### following bare metal install from https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04
sudo apt-get update -y
sudo apt-get install -y python-pip python-dev libpq-dev postgresql postgresql-contrib nginx

sudo apt-get update -y
sudo apt-get install -y python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx

###create the database for the project

sudo -u postgres psql -c "CREATE DATABASE myproject"
sudo -u postgres psql -c "CREATE USER myprojectuser WITH PASSWORD 'password'"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET client_encoding TO 'utf8'"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed'"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET timezone TO 'UTC'"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser"

###set up venv
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv
# mkdir ./myproject
cd ./myproject
virtualenv myproject
source myproject/bin/activate

###do the pip install 
pip install django gunicorn psycopg2
# replace with requirements.txt









