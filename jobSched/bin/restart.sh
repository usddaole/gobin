#!/bin/bash

# 设置变量
APP_NAME="jobSched"
LOG_FILE="output.log"
PID_FILE="jobSched.pid"


# 进入 gobin 目录并拉取最新代码
echo "Updating code in ../../../gobin..."
cd ../../../gobin || { echo "Failed to cd into ../../../gobin"; exit 1; }
git pull

# 回到原来的目录
cd - > /dev/null

# 检查 GlobalConfig 是否存在，不存在则创建软链接
if [ ! -e "../GlobalConfig" ]; then
    echo "Creating symlink for GlobalConfig..."
    ln -s "$(realpath ../../GlobalConfig)" ../GlobalConfig
fi

# 备份当前的可执行文件
if [ -f "$APP_NAME" ]; then
    echo "Backing up current $APP_NAME to ${APP_NAME}_back..."
    mv "$APP_NAME" "${APP_NAME}_back"
fi

# 复制新的可执行文件
echo "Copying new executable $APP_NAME..."
cp "../../../gobin/$APP_NAME/bin/$APP_NAME" ./

# 修改新可执行文件权限
chmod +x "$APP_NAME"

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
nohup ./"$APP_NAME" > "$LOG_FILE" 2>&1 &

# 记录新的 PID
echo $! > "$PID_FILE"
echo "$APP_NAME started with PID $(cat $PID_FILE)"


