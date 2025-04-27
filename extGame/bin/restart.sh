#!/bin/bash

# 设置变量
APP_NAME="extGame"
LOG_FILE="output.log"
PID_FILE="extGame.pid"

# 终止旧进程（如果存在）
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo "Stopping old process ($OLD_PID)..."
        kill -9 $OLD_PID
        sleep 1
    fi
    rm -f "$PID_FILE"
fi

# 启动新的进程
echo "Starting $APP_NAME..."
nohup ./$APP_NAME > "$LOG_FILE" 2>&1 &

# 记录新的 PID
echo $! > "$PID_FILE"
echo "$APP_NAME started with PID $(cat $PID_FILE)"


