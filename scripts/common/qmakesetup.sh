#!/bin/sh

build_target()
{

ROOT=$1
NAME=$2
PROCCOUNT=$3
PACKAGE=$4

cd $ROOT/$NAME

MAKEFILE=Makefile.$NAME

$QMAKE "DEFINES+=ISIS_DESKTOP" $NAME.pro -o Makefile.$NAME

if [ "$?" != "0" ] ; then
   echo Failed to qmake $NAME
   exit 1
fi

make -f Makefile.$NAME -j$PROCCOUNT

if [ "$?" != "0" ] ; then
   echo Failed to make $NAME
   exit 1
fi

make -f Makefile.$NAME install

if [ "$?" != "0" ] ; then
   echo Failed to install $NAME
   exit 1
fi

if [ ! -z "$PACKAGE" ]; then 
    make -f Makefile.$NAME $PACKAGE
fi

}
