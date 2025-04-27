PID_FILE="front.pid"

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
