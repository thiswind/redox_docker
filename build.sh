#!/bin/bash - 
#===============================================================================
#
#          FILE: build.sh
# 
#         USAGE: ./build.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019/07/14 02:03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

docker build -t myredox:latest .

# do some clean
docker container prune
docker image prune

