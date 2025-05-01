#!/bin/bash

# 遍历当前目录下的所有目录
for dir in */; do
  # 进入每个目录
  if [ -d "$dir" ]; then
    cd "$dir" || continue

    # 检测是否存在 bin 目录
    if [ -d "bin" ]; then
      echo "找到 bin 目录: $PWD/bin"
      cd "bin" || continue

      # 检测是否存在 restart.sh 文件并且可执行
      if [ -f "restart.sh" ] && [ -x "restart.sh" ]; then
        echo "执行: $PWD/restart.sh"
        ./restart.sh
        result=$?
        if [ "$result" -eq 0 ]; then
          echo "restart.sh 执行成功。"
        else
          echo "restart.sh 执行失败，返回码: $result"
        fi
      else
        echo "bin 目录下未找到 restart.sh 文件或该文件不可执行。"
      fi

      # 返回上一级目录 (bin -> current_dir)
      cd .. || continue
    fi

    # 返回上一级目录 (current_dir -> script's starting dir)
    cd .. || continue
  fi
done

echo "遍历完成。"