# mypkg
 listener.py→テスト用

# System Status ノード

## 概要
このROS 2パッケージは、現在のシステムリソース（CPU使用率とメモリ使用率）を定期的にトピックにパブリッシュするノードを提供します。システムの監視やリソース使用状況のログ収集に役立ちます。

###　実行方法
端末１で立ち上げ
```
$ ros2 run mypkg system_status
```

端末２（サブスクライバ役）でトピックのデータを確認
```
$ ros2 topic echo /system_status_publisher
```

#### 実行結果例
```
date: "CPU: 15.2%,Memory: 45.7%"
```


#必要なソフトウェア


・ROS2 
・Ubuntu 22.04
・psutilライブラリ（python）

##テスト環境
・OS:Ubuntu 22.04
・Python 3.10

###ライセンス
このソフトウェアパッケージは、3条項BSDライセンスの下で再頒布および使用が許可されます。

####著者
坂田　拓海
© 2025
