#!/bin/sh

if [ $# != 2 ]
then
    echo "usage: $0 REPO_LABEL LOCAL_PKGS_DIR"
	exit 1
fi

REPO_LABEL=$1
LOCAL_PKGS_DIR=`realpath $2`

createrepo $LOCAL_PKGS_DIR

# create repo file packages
LOCAL_REPO_FILE=./$REPO_LABEL.repo
rm -rf $LOCAL_REPO_FILE
echo "[$REPO_LABEL]" >> $LOCAL_REPO_FILE
echo "name=$REPO_LABEL" >> $LOCAL_REPO_FILE
echo "baseurl=file://$LOCAL_PKGS_DIR" >> $LOCAL_REPO_FILE
echo "gpgcheck=0" >> $LOCAL_REPO_FILE
echo "enabled=1" >> $LOCAL_REPO_FILE
mv -f $LOCAL_REPO_FILE /etc/yum.repos.d

# clean yum repository
yum repolist clean
yum repolist all
