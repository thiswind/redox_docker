#!/bin/bash - 
#===============================================================================
#
#          FILE: docker.sh
# 
#         USAGE: ./docker.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019/07/14 02:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

docker run --privileged --cap-add MKNOD --cap-add SYS_ADMIN --device /dev/fuse \
	-e LOCAL_UID="$(id -u)" -e LOCAL_GID="$(id -g)" \
	-v redox-"$(id -u)-$(id -g)"-cargo:/usr/local/cargo \
	-v redox-"$(id -u)-$(id -g)"-rustup:/usr/local/rustup \
	-v "$(pwd):$(pwd)" -w "$(pwd)" --rm -it myredox:latest "$@"

