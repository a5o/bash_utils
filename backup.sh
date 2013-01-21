#!/bin/bash

if [ -z $1 ]
then
	echo USAGE $(basename $0) "<drive>" 
	exit 1
fi

BACKUP_DIR=/cygdrive/$1/Backup
SOURCE_DIR=/cygdrive/

date=$(date +%Y%m%d_%H%M%S)
last_update=$(cat $BACKUP_DIR/last_update)

rsync -rltP --no-p --no-g --chmod=ugo=rwX --link-dest=$BACKUP_DIR/${last_update} --files-from=$BACKUP_DIR/to_backup.txt --delete --delete-excluded --exclude-from=$BACKUP_DIR/to_exclude.txt $SOURCE_DIR $BACKUP_DIR/$date |tee $BACKUP_DIR/$date.log

echo $date > $BACKUP_DIR/last_update
