
# Github での警告対応

npm と yarn を 両方使用しているのが問題である模様。

## 参考
- [Githubから来た"A new security advisory on minimist affects"に対応するときに出たエラーと対処方法 \- CrossRoad](https://www.crossroad-tech.com/entry/github-security-alert)


## 対処手順

1. package-lock.json を消す
2. yarn を更新する

```bash
yarn upgrade --latest
```


