#!/bin/bash

# 機能ごとにファイルを用意して指定する
input_csv='../../job_definition_csv/execution_placesapi_unit.csv'
output_yaml='../yaml/execution_placesapi_main.yaml'
main_job_name='execution_placesapi'

# 固定指定
template_ref_yaml='./job_ref_template.yaml'
template_main_yaml='./job_def_template_main.yaml'
input_main_csv='../../job_definition_csv/main.csv'

# ジェネレーターシェル実行
./job_def_yaml_generator_main.sh ${template_ref_yaml} ${template_main_yaml} ${input_csv} ${input_main_csv} ${output_yaml} ${main_job_name}
status=$?

exit ${status}
