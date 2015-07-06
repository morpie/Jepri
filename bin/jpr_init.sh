#!/bin/sh


if [ "$#" -ne 1 ]; then
	echo "Usage:"
	echo "pass as argument the path/projectName"
	exit
fi

# Creating the file tree
mkdir $1
cd $1
PROJECT_HOME=$(pwd)

mkdir .jepri
cd .jepri
mkdir data

#creating database
sqlite3 $PROJECT_HOME/.jepri/data/database.db 'CREATE TABLE project_info (key TEXT,value TEXT)'
sqlite3 $PROJECT_HOME/.jepri/data/database.db 'CREATE TABLE tickets (ID INTEGER PRIMARY KEY,description TEXT,owner TEXT, open_version TEXT, delivered_version TEXT, type TEXT, status TEXT, links TEXT, history TEXT, attachments TEXT)'

echo "Enter the project ID (no spaces)"
read PROJECT_ID

echo "Enter the users of the project separated with spaces"
echo "The default user is Admin, hit enter if no other users are needed"
read PROJECT_USERS

PROJECT_CREATION_DATE=$(date)

sqlite3 $PROJECT_HOME/.jepri/data/database.db << EOS
INSERT INTO project_info (key,value) VALUES ('project_name','$1');
INSERT INTO project_info (key,value) VALUES ('project_id','$PROJECT_ID');
INSERT INTO project_info (key,value) VALUES ('project_creation_date','$PROJECT_CREATION_DATE');
INSERT INTO project_info (key,value) VALUES ('ticket_types','issue release'); 
INSERT INTO project_info (key,value) VALUES ('project_users','Admin $PROJECT_USERS');
INSERT INTO project_info (key,value) VALUES ('ticket_status','open analysis development closed');
EOS

