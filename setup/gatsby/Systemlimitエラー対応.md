
# gatsby更新時のdevelop起動エラー

gatsby develop実行時に以下のエラーが出た

`Error: ENOSPC: System limit for number of file watchers reached, watch`

原因はファイルシステムイベントを監視するinotifyの監視対象の上限になったとのこと


## 監視上限数を増やす

```bash
# 現在（デフォルト）の上限数を確認
cat /proc/sys/fs/inotify/max_user_watches
# → 8192


# 上限数を582222に変更する
echo fs.inotify.max_user_watches=582222 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
# → fs.inotify.max_user_watches=582222
# → fs.inotify.max_user_watches = 582222


# 上限数が変わっていることを確認
cat /proc/sys/fs/inotify/max_user_watches
# → 582222
```


## 参考
- [gatsby更新時のdevelop起動エラー（System limit for number of file watchers reached）](https://ichinari.work/gatsby_Linux_20190505)
- [LinuxでSystem limit for number of file watchers reachedが出る場合の原因と対策 \| virtualiment](https://virment.com/how-to-fix-system-limit-for-number-of-file-watchers-reached/)


