#!/bin/bash
########################################################
# This program is for producing the various size of files
# parameters:
# -n: the number of files
# -s: the size of files
# -u: the unit of files,like Kb,Mb,Gb
# -r: produce the random size of file,between 1-r unit
# -d: the directory of saving files
# for example
# ./create_file.sh -n 100 -s 100 -u MB 
# ./create_file.sh -n 100 -u MB -r 50
#######################################################
numbers=1
size=1
blocksize="kb"
count=1
random=1
dir=""
count_for_loop=0
setBlockSize(){
    case $1 in 
	"kb" | "Kb" | "KB" | "kB" )  blocksize="KB";;
	"Mb" | "mb" | "MB" | "mB" )  blocksize="MB";;
	"Gb" | "GB" | "gb" | "gB" )  blocksize="GB";;
    esac
}
# the colon represent the option need parameter
while getopts "n:s:u:r:d:" optname
do
    case "$optname" in 
	n) numbers=$OPTARG ;;
	s) size=$OPTARG ;;
	u) setBlockSize $OPTARG ;;
	r) random=$OPTARG ;;
	d) dir=$OPTARG ;;
    esac
done
# after get all the parameters, start to produce files
echo $dir
if [ $random -ne 1 ]
then
    while [ $count_for_loop -lt $numbers ];do
    count=`expr $RANDOM % $random`
    dd if=/dev/zero of=${dir}/${count_for_loop}_${count}_${blocksize} bs=1${blocksize} count=$count
    let count_for_loop+=1
    done
else
    if [ $blocksize == "GB" ];then
	count=$[1024*${size}]
	blocksize="MB"
    else
	count=$size
    fi
    while [ $count_for_loop -lt $numbers ];do
	dd if=/dev/zero of=${dir}/${count_for_loop}_${size}_${blocksize} bs=1${blocksize} count=$count
	let count_for_loop+=1
    done
fi
exit 0
