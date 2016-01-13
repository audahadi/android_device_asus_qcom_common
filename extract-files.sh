#!/bin/bash

function extract () {
    for FILE in `egrep -v '(^#|^$)' $1`; do
        # Split the file from the destination (format is "file[:destination]")
        OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
        FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
        DEST=${PARSING_ARRAY[1]}
        if [ -z "$DEST" ]; then
            DEST=$FILE
        fi
        DIR=`dirname $DEST`
        if [ ! -d $BASE/$DIR ]; then
            mkdir -p $BASE/$DIR
        fi

        if [ "$SETUP" != "1" ]; then
            if [ -z $LDIR ]; then
                adb pull /system/$FILE $BASE/$DEST
            else
                cp $LDIR/system/$FILE $BASE/$DEST
            fi
            # if file dot not exist try destination
            if [ "$?" != "0" ]; then
                if [ -z $LDIR ]; then
                    adb pull /system/$DEST $BASE/$DEST
                else
                    cp $LDIR/system/$DEST $BASE/$DEST
                fi
            fi
        fi
    done
}

BASE=../../../vendor/$VENDOR/msm8916-common/proprietary
DEVBASE=../../../vendor/$VENDOR/$DEVICE/proprietary

while getopts ":nhsd:" options
do
  case $options in
    n ) NC=1 ;;
    d ) LDIR=$OPTARG ;;
    s ) SETUP=1 ;;
    h ) echo "Usage: `basename $0` [OPTIONS] "
        echo "  -n  No cleanup"
        echo "  -d  Fetch blob from filesystem"
        echo "  -s  Setup only, no extraction"
        echo "  -h  Show this help"
        exit ;;
    * ) ;;
  esac
done

if [ "$NC" != "1" ]; then
  rm -rf $BASE/*
  rm -rf $DEVBASE/*
fi

extract ../../$VENDOR/msm8916-common/proprietary-files.txt $BASE
extract ../../$VENDOR/$DEVICE/proprietary-files.txt $DEVBASE

./setup-makefiles.sh
