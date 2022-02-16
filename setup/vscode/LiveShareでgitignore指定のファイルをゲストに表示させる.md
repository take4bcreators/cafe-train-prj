
# LiveShareでgitignore指定のファイルをゲストに表示させる

## 参考
- [【Tips】VSCode Live Share で\.gitignore に記述したファイルが共有されない \- Qiita](https://qiita.com/skokado/items/67629415a7a2167a8483)
- [気持ちよくLive Shareを使うために](https://zenn.dev/erukiti/articles/liveshare-setting)

## 方法

プロジェクトの直下に `.vsls.json` ファイルを作成し、以下の内容を記述する。

```json
{
    "$schema": "http://json.schemastore.org/vsls",
    "gitignore":"none"
}
```


