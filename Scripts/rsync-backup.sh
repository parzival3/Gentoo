rsync -aAXH --info=progress2 \
--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \ 
/ /run/media/enrico/BACKUP_DESKTOP/Manjaro/
