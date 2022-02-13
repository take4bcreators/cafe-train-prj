#!/bin/bash

# 引数格納
template_ref_yaml='./job_ref_template.yaml'
template_main_yaml='./job_def_template_main.yaml'
input_csv='../../job_definition_csv/import_train_unit.csv'
input_main_csv='../../job_definition_csv/main.csv'
output_yaml='../yaml/import_train_main.yaml'
main_job_name='input_csv'

# ジェネレーターシェル実行
./job_def_yaml_generator_main.sh ${template_ref_yaml} ${template_main_yaml} ${input_csv} ${input_main_csv} ${output_yaml} ${main_job_name}
status=$?

exit ${status}
