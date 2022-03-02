#!/bin/bash

# 引数格納
template_yaml='./job_def_template.yaml'
input_csv='../../job_definition_csv/build_site_unit.csv'
output_yaml='../yaml/build_site_unit.yaml'

# ジェネレーターシェル実行
./job_def_yaml_generator_unit.sh ${template_yaml} ${input_csv} ${output_yaml}
status=$?

exit ${status}
