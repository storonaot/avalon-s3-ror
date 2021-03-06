#!/bin/bash

# Updating the system
sudo apt-get -y update
# Installing necessary software
sudo apt-get -y install curl nodejs git

# Installing RVM and Ruby
# Importing the GPG key
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
# Downloading and installing RVM
curl -sSL https://get.rvm.io | bash -s stable
# Making RVM executable
source $HOME/.rvm/scripts/rvm
# Installing the latest Ruby
rvm use --default --install 2.3.1
# Installing necessary gems
gem install bundler --no-ri --no-rdoc
gem install rails --no-ri --no-rdoc

# Installing Postgres
sudo apt-get -y install postgresql postgresql-contrib postgresql-server-dev-9.5
# Creating the role with privileges
# -s makes a superuser, -r allows role creation, -d allows DB creation
sudo -u postgres createuser -srd experteese_admin
# Creating the DBs
sudo -u postgres createdb experteese_development
sudo -u postgres createdb experteese_test
sudo -u postgres createdb experteese_production
# Allowing Postgres to listen all ports
echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/9.5/main/postgresql.conf
echo "host all all all trust" | sudo tee -a /etc/postgresql/9.5/main/pg_hba.conf
sudo -u postgres psql -c "ALTER ROLE experteese_admin WITH PASSWORD 'password';"
sudo service postgresql restart
