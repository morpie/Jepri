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

