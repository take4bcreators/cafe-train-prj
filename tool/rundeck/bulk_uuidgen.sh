#!/bin/bash

# UUID実行回数（第1引数 or デフォルト値）
exec_times=${1:-3}

# 数値・文字列判定（数値のみOK）
if [[ ! "${exec_times}" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
  echo "引数に数字以外が指定されています"
  exit 1
fi

# 有効値判定（1以上のみOK）
if [ ${exec_times} -lt 1 ]; then
  echo "引数に1より小さい数字が指定されています"
  exit 1
fi

# 実行
for i in $(seq 1 ${exec_times}); do
    uuidgen
done

exit 0
