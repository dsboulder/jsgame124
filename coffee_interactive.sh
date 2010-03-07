#!/bin/sh

if [ ! `which rlwrap` ]; then
  echo "Please sudo port install rlwrap"
	exit
fi

cd game && rlwrap coffee -i
