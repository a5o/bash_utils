#!/bin/bash

function recreate_subdir {
        echo creating $2/$(basename $1)
        mkdir $2/$(basename $1)
        for f in $(ls $1);
        do
                if [ -f $1/$f ];
                then
                        ln -s $1/$f $2/$(basename $1)/$f;
                elif [ -d $1/$f ];
                then
                        recreate_subdir $1/$f $2/$(basename $1);
                fi
        done;
}

WORKDIR=$(pwd)

for dir in $(cat $1);
do
        recreate_subdir $WORKDIR/$2 $dir;
done
