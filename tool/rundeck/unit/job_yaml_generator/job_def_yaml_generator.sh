#!/bin/bash

# 引数判定
if [ $# -ne 3 ]; then
    echo "引数は 3 つ指定してください"
    echo "  1 : template_yaml"
    echo "  2 : input_csv"
    echo "  3 : output_yaml"
    exit 1
fi

# 引数格納
template_yaml=$1
input_csv=$2
output_yaml=$3

# ファイル存在判定
if [ ! -s ${template_yaml} ]; then
    echo "テンプレートYAMLファイルが存在しないか、ファイルサイズが0です"
    echo "ファイル名：${template_yaml}"
    exit 1
fi

if [ ! -f ${input_csv} ]; then
    echo "定義用CSVファイルが存在しません、ファイルサイズが0です"
    echo "ファイル名：${input_csv}"
    exit 1
fi


# CSVの列数を取得
csv_col_cnt=$(cat ${input_csv} | awk -F ',' 'NR==1{print NF}')

# CSVの列名を配列にまとめる
col_names=()
for i in $(seq 1 ${csv_col_cnt}); do
    col_names+=( $(cat ${input_csv} | awk -F ',' -v i=${i} 'NR==1{print $i}') )
done

# 初期化して 行分 実行する
: > ${output_yaml}
rownum=0
for rowvalue in $(cat ${input_csv} | sed '/^$/d'); do
    let rownum++
    
    # 1行目はヘッダーなのでスキップ
    if [ ${rownum} -eq 1 ]; then continue; fi
    
    # sed コマンド組み立て用変数
    sedcmd="sed"
    
    # CSV の列ごとに sed の置換オプションを生成
    for i in $(seq 1 ${csv_col_cnt}); do
        arrnum=$(( $i - 1 ))
        colname=${col_names[${arrnum}]}
        colvalue=$(echo "${rowvalue}" | awk -F ',' -v i=${i} '{print $i}')
        escaped_colvalue=$(echo "${colvalue}" | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/\./\\\./g' )
        sedrepstr="-e 's/<${colname}>/${escaped_colvalue}/g'"
        sedcmd+=" ${sedrepstr}"
    done
    
    # 置換オプションが出来なかった場合はスキップ
    if [ "${sedcmd}" == "sed" ]; then continue; fi
    
    # テンプレートと書き出し先の情報を付加して sed 実行
    sedcmd+=" ${template_yaml} >> ${output_yaml}"
    eval ${sedcmd}
    
done

exit 0
