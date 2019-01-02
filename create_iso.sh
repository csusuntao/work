#!/bin/sh

CDROM_DEV=/dev/sr0
CDROM_MOUNT_DIR=/opt/cdrom

# umount cdrom

# mount cdrom
mkdir -p $CDROM_MOUNT_DIR; rm -rf $CDROM_MOUNT_DIR/*
mount $CDROM_DEV $CDROM_MOUNT_DIR

# create repo file for cdrom
ISO_REPO_FILE=./iso.repo
rm -rf $ISO_REPO_FILE
echo "[iso_repo]" >> $ISO_REPO_FILE
echo "name=iso_repo" >> $ISO_REPO_FILE
echo "baseurl=file://$CDROM_MOUNT_DIR" >> $ISO_REPO_FILE
echo "gpgcheck=0" >> $ISO_REPO_FILE
echo "enabled=1" >> $ISO_REPO_FILE
mv -f $ISO_REPO_FILE /etc/yum.repos.d

# clean yum repository
yum repolist clean
yum repolist all
