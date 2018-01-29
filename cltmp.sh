#!/bin/bash

set -e

#_______________________________________________________________________________
target_dir=$PWD
command=`basename $0`
verbose=0  # 0: default, 1: 2>/dev/null
rm="rm -f"
#rm="rm -i"

#_______________________________________________________________________________
echo_usage()
{
    echo "Usage: $command [target_dir]"
}

#_______________________________________________________________________________
find_file()
{
    find ${target_dir} \
	-name "\#*\#" -or   \
	-name "*~"    -or   \
	-name ".*~"
}

##### main
#_______________________________________________________________________________
if [ $# == 1 ]; then
    target_dir=$1
    if [ ! -d ${target_dir} ]; then
	echo "$command error: can't find \"$target_dir\" "
	echo_usage
	exit 1
    fi
fi

echo "==> Finding $target_dir"
case $verbose in
    0)
	target=(`find_file | \tr '\n' ' '`) ;;
    1)
	target=(`find_file 2>/dev/null | \tr '\n' ' '`) ;;
esac

if [ -z "$target" ]; then
    echo "==> No file"
    exit 0
fi

#echo "==> Showing ..."
i=0
for f in ${target[@]}; do
    i=`expr $i + 1`
    ii=`printf %03d $i`
    echo " $ii: $f"
done

echo -n "==> Clean up ? [y/n]: "
read input
case $input in
    y|Y|yes|Yes|YES)
	for r in ${target[@]}; do
	    echo "- Removing $r"
	    $rm $r
	done
	echo "==> $i files removed"
	;;
    *)
	echo "==> quit"
	;;
esac
