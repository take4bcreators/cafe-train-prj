
# LiveShareをCentOSで行う方法

## 参考

- [docker内でliveshareする方法 \- Qiita](https://qiita.com/torun225/items/3bc81bf3ad7bfc007770)
- [Linux installation details \- Visual Studio Live Share \- Live Share \| Microsoft Docs](https://docs.microsoft.com/en-us/visualstudio/liveshare/reference/linux#detailed-library-requirements)

## 概要
CentOS で Live Share をやるには、必要なライブラリを別途インストールする必要がある。

```bash
yum install openssl-libs krb5-libs zlib libicu libsecret gnome-keyring desktop-file-utils xprop
```



