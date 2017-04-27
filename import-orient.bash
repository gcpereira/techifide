#!/bin/bash

# HOW TO IMPLEMENT
# 
# 1. create a enviroment var ORIENTDB_HOME setting to you orientdb folder Ex.: ORIENTDB_HOME=/etc/OrientDB
# 2. save this script at your users bin folder Ex.: /Users/Gustavo/bin
# 3. create a symbolic link to get rid of the .bash
# $ ln -s import-orient.bash import-orient

usage() {
    echo "usage: import-orient [user] [pass] [database] "
    echo "  -user       OrientDB user"
    echo "  -pass       OrientDB password"
    echo "  -database   the .gz file to be import"
    exit 1
}

# invoke  usage
# call usage() function if database not supplied
[[ $# -eq 0 ]] && usage

user=$1
pass=$2
orientdb=$ORIENTDB_HOME     # PATH FOR THE ORIENTDB FOLDER
host='remote:localhost'
database=$3                 # THE DATABASE AND THE .GZ FILE MUST HAVE THE SAME NAME

$orientdb/bin/console.sh "drop database $host/$database $user $pass;"
$orientdb/bin/console.sh "create database plocal:$orientdb/databases/$database;"
$orientdb/bin/console.sh "connect $host/$database $user $pass;import database migrations/$database.gz -preserveClusterIDs=true;"
