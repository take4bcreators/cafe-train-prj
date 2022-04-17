# cafe-train-prj
カフェ路線図プロジェクト メイン開発リポジトリ


## 実行手順

1. 次のファイルで対象を指定する

- batch/csv/target/fetch_target_chain.csv （データ取得対象のカフェチェーン指定）
- batch/csv/target/fetch_target_line.csv （データ取得対象の路線情報指定）
- batch/csv/target/page_create_target_line.csv （サイトページ作成対象の路線情報指定）

2. 次のシェル設定ファイルの「DEPLOY_PRD_DEV_FLAG」を確認・変更する

- config/grp_env_deploy_site.sh

3. Rundeck （http://localhost:4440） を開いて、ジョブを実行する


## 実行前提条件

「setup/main/全体構築手順.md」も参照。

1. PostgreSQL の設定、テーブルが作成されていること
2. Rundeck の設定、ジョブの作成がされていること
3. Gatsby の設定、必要なモジュールがインストールされていること
4. 次のファイルが配置されていること

- 駅データJPのCSVファイル
    - batch/csv/ekidatajp/companyYYYYMMDD.csv
    - batch/csv/ekidatajp/joinYYYYMMDD.csv
    - batch/csv/ekidatajp/lineYYYYMMDDfree.csv
    - batch/csv/ekidatajp/stationYYYYMMDDfree.csv
- 対象設定用ファイル
    - batch/csv/target/fetch_target_chain.csv
    - batch/csv/target/fetch_target_line.csv
    - batch/csv/target/page_create_target_line.csv
- API設定ファイル
    - env/.env
- ビルド設定ファイル
    - ssg/.env.development
    - ssg/.env.production
- Rundeck 用 プロジェクトパス読み込みシェル（所有者：rundeck）
    - ~rundeck/PROJECT_ROOT.sh

5. 次のファイルの内容が設定されていること

- env/.env
    - GM_API_KEY の記述
    - NL_TOKEN の記述
- ssg/.env.development
    - GATSBY_TRACKING_ID の記述
- ssg/.env.production
    - GATSBY_TRACKING_ID の記述
