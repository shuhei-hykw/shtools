#!/bin/sh

list=(`find . -type f`)

for f in ${list[@]}
do
    if [ ! -s $f ]; then
	echo $f
    fi
done
