#!/bin/bash

# 引数格納
template_yaml='./job_def_template.yaml'
input_csv='../../job_definition_csv/execution_placesapi_unit.csv'
output_yaml='../yaml/execution_placesapi_unit.yaml'

# ジェネレーターシェル実行
./job_def_yaml_generator_unit.sh ${template_yaml} ${input_csv} ${output_yaml}
status=$?

exit ${status}
