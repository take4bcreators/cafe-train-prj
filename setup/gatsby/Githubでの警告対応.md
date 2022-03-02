
# Github での警告対応

## 参考
- [GitHubでpackage\-lock\.jsonに記述されているバージョンが古いと警告された時の修正方法](https://webrandum.net/github-package-lock-json-error/)
- [npm install \-g npm\-check\-updates](https://qiita.com/enven_omiomi/items/84e8f4f9a00057847f79)

## 1. package-lock.json の警告
GitHub で `package-lock.json` に記述されているバージョンが古いと警告された時の修正方法


```bash
# とりあえず試す
npm install
```

package-lock.json が更新されない場合は、以下を実施。

```bash
# root になる
su -

# npm-check-updates
npm install -g npm-check-updates

# パッケージ更新の確認
ncu

# package.jsonの修正
ncu -u

# package.jsonが更新されたのでパッケージを更新する
npm install
```







