#!/bin/bash
export local_dir="docbao"
export remote_dir="docbao"
echo $local_dir
echo $remote_dir
PATH=/home/pi/miniconda3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games

while true; do
    echo "start running docbao"
    cd ~/$local_dir/backend/category
    #rm *
    cd ~/$local_dir/backend
    rclone sync -v $remote_dir:category ~/$local_dir/backend/category
    rclone copy -v $remote_dir:output ~/$local_dir/backend/input
    python3 ~/$local_dir/backend/crawl.py
    rclone delete $remote_dir:export/log_data.json
    rclone copy -v ~/$local_dir/backend/export $remote_dir:export	
    killall -9 firefox
    killall geckodriver
    echo "stop docbao, sleep 50s"
    sleep 50
done
