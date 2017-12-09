#!/bin/bash
if [ -h /dev/disk/by-label/BackButters ] && [ -h /dev/disk/by-label/BACKUP_GENTOO]; then 
	logger "Started Backup"
	rsync -aAXH --info=progress2 \
	/run/media/enrico/BackButters /run/media/enrico/BACKUP_GENTOO/HardDisk/
	logger "Finished Backup"
	sync
fi	
