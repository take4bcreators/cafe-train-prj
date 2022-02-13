#!/bin/bash

# 引数判定
if [ $# -ne 6 ]; then
    echo "引数は 6 つ指定してください"
    echo "  1 : template_ref_yaml"
    echo "  2 : template_main_yaml"
    echo "  3 : input_csv"
    echo "  4 : input_main_csv"
    echo "  5 : output_yaml"
    echo "  6 : main_job_name"
    exit 1
fi

# 引数格納
template_ref_yaml=$1
template_main_yaml=$2
input_csv=$3
input_main_csv=$4
output_yaml=$5
main_job_name=$6

# template_ref_yaml='./job_ref_template.yaml'
# template_main_yaml='./job_def_template_main.yaml'
# input_csv='../../job_definition_csv/import_train_unit.csv'
# input_main_csv='../../job_definition_csv/main.csv'
# output_yaml='../yaml/import_train_main.yaml'
# main_job_name='input_csv'


# 設定項目
main_job_col_name='MAINJOBNAME'
jobref_tag_name="MAINJOBREF"
tmp_file="./gentmp_1.$$.tmp"
tmp_split_file="gentmp_split_$$_"


# ファイル存在判定
if [ ! -s ${template_ref_yaml} ]; then
    echo "テンプレートYAMLファイル（REF）が存在しないか、ファイルサイズが0です"
    echo "ファイル名：${template_ref_yaml}"
    exit 1
fi

if [ ! -s ${template_main_yaml} ]; then
    echo "テンプレートYAMLファイル（メイン用）が存在しないか、ファイルサイズが0です"
    echo "ファイル名：${template_main_yaml}"
    exit 1
fi

if [ ! -f ${input_csv} ]; then
    echo "定義用CSVファイル（Unit用）が存在しないか、ファイルサイズが0です"
    echo "ファイル名：${input_csv}"
    exit 1
fi

if [ ! -f ${input_main_csv} ]; then
    echo "定義用CSVファイル（メイン用）が存在しないか、ファイルサイズが0です"
    echo "ファイル名：${input_main_csv}"
    exit 1
fi


# CSVの列数を取得
csv_col_cnt=$(cat ${input_csv} | awk -F ',' 'NR==1{print NF}')

# CSVの列名を配列にまとめる
col_names=()
for i in $(seq 1 ${csv_col_cnt}); do
    col_names+=( $(cat ${input_csv} | awk -F ',' -v i=${i} 'NR==1{print $i}') )
done

# 初期化して 行数分 実行する
: > ${tmp_file}
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
    sedcmd+=" ${template_ref_yaml} >> ${tmp_file}"
    eval ${sedcmd}
    
done


# MAIN用CSVの列数を取得
csv_col_cnt=$(cat ${input_main_csv} | awk -F ',' 'NR==1{print NF}')

# MAIN用CSVの列名を配列にまとめる
col_names=()
for i in $(seq 1 ${csv_col_cnt}); do
    col_names+=( $(cat ${input_main_csv} | awk -F ',' -v i=${i} 'NR==1{print $i}') )
done

# 対象行のデータ取得
jobname_col_num=$(cat ${input_main_csv} | head -1 | sed 's/,/ /g' | xargs -n 1 | awk -v jbname="${main_job_col_name}" '$1==jbname{print NR}')
target_row_num=$(cat ${input_main_csv} | awk -F ',' -v jbname=${main_job_name} -v col=${jobname_col_num} '$col==jbname{print NR}')
target_row_data=$(cat ${input_main_csv} | awk -F ',' -v rownum=${target_row_num} 'NR==rownum{print $0}')

# 初期化して 行数分 実行する
: > ${output_yaml}

# sed コマンド組み立て用変数
sedcmd="sed"

# CSV の列ごとに sed の置換オプションを生成
for i in $(seq 1 ${csv_col_cnt}); do
    arrnum=$(( $i - 1 ))
    colname=${col_names[${arrnum}]}
    colvalue=$(echo "${target_row_data}" | awk -F ',' -v i=${i} '{print $i}')
    escaped_colvalue=$(echo "${colvalue}" | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/\./\\\./g' )
    sedrepstr="-e 's/<${colname}>/${escaped_colvalue}/g'"
    sedcmd+=" ${sedrepstr}"
done

# 置換オプションが出来なかった場合はエラー
if [ "${sedcmd}" == "sed" ]; then
    echo "エラー"
    exit 1
fi

# テンプレートと書き出し先の情報を付加して sed 実行
sedcmd+=" ${template_main_yaml} >> ${output_yaml}"
eval ${sedcmd}

# 指定タグの行番号を取得して、分割 → ジョブ情報を付加して結合
jobref_row_num=$(cat ${output_yaml} | sed -n "/<${jobref_tag_name}>/=")
split -l "${jobref_row_num}" -d ${output_yaml} "${tmp_split_file}"
cat "${tmp_split_file}00" ${tmp_file} "${tmp_split_file}01" > ${output_yaml}
sed -i "s/<${jobref_tag_name}>//g" ${output_yaml}

# 一時ファイル削除
if [ -f ${tmp_file} ]; then rm ${tmp_file}; fi
if [ -f "${tmp_split_file}00" ]; then rm "${tmp_split_file}00"; fi
if [ -f "${tmp_split_file}01" ]; then rm "${tmp_split_file}01"; fi

exit 0
