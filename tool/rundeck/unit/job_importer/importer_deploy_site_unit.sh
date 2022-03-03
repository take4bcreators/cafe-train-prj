#!/bin/bash

# 指定項目
rundeck_project='cafe-train-prj'
yaml_file='../yaml/deploy_site_unit.yaml'

# ジョブ定義yamlのインポート
rd jobs load -p ${rundeck_project} -f ${yaml_file} -F yaml

exit 0
