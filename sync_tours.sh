#!/bin/bash

# 1. Config - Use absolute paths for Cron
DOCKER_BIN="/usr/bin/docker"
CONTAINER_NAME="api-app-1"
HOST_LOG="/home/ubuntu/api/storage/logs/sync_tours.log"
TOTAL_PAGES=300
CHUNK_SIZE=10

# 2. Ensure directory exists
mkdir -p /home/ubuntu/api/storage/logs

echo "[$(date)] --- STARTING FULL SYNC ---" >> $HOST_LOG

# 3. The Chunking Loop
for (( i=1; i<=$TOTAL_PAGES; i+=$CHUNK_SIZE )); do
    START=$i
    END=$((i + CHUNK_SIZE - 1))
    if [ $END -gt $TOTAL_PAGES ]; then END=$TOTAL_PAGES; fi

    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] Host: Starting chunk $START to $END" >> $HOST_LOG

    # IMPORTANT: Removed -it flag and used absolute docker path
    $DOCKER_BIN exec $CONTAINER_NAME php artisan sync:tours "$START-$END" 2>&1 | tee -a $HOST_LOG

    echo "[$TIMESTAMP] Host: Finished chunk $START to $END" >> $HOST_LOG
    sleep 2
done

echo "[$(date)] --- SYNC COMPLETE ---" >> $HOST_LOG