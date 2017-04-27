#!/bin/bash
# A simple script to automatic add the ticket code at the commit for better integration between Jira and Bitbucket
#
# HOW TO IMPLEMENT
# 
# 1. save this script at your users bin folder Ex.: /Users/Gustavo/bin
# 2. create a symbolic link to get rid of the .bash
# $ ln -s commit.bash commit


# get the current branch
branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

# get the ticket base on pattern feature/[prefix]-[ticketNumber]-[title]
IFS='-' read -r -a ticket <<< "$branch"

# get the prefix base on pattern [folder]/[prefix]
IFS='/' read -r -a prefix <<< "$ticket"

# debug
# echo "${prefix[1]}-${ticket[1]} $1"

git commit -am "${prefix[1]}-${ticket[1]} $1"
