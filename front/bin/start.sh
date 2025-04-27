APP_NAME="front"
LOG_FILE="output.log"

echo "Starting $APP_NAME..."
nohup ./$APP_NAME > "$LOG_FILE" 2>&1 &

# 记录新的 PID
echo $! > "$PID_FILE"
echo "$APP_NAME started with PID $(cat $PID_FILE)"
