#!/bin/bash

# デフォルトディレクトリ設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2 ワークスペースに移動
cd $dir/ros2_ws

# ワークスペースをビルド
colcon build
if [ $? -ne 0 ]; then
    echo "ビルドに失敗しました"
    exit 1
fi

# ROS 2 環境をセットアップ
source install/setup.bash

# ログファイルの設定
LOG_FILE=/tmp/mypkg.log

# calendar_notifier を実行してログに保存
echo "calendar_notifier を実行し、ログを $LOG_FILE に保存します"
timeout 20 bash -c "ros2 run mypkg calendar_notifier > $LOG_FILE 2>&1"

# ログファイルのチェック
echo "ログファイルを確認中..."
if [ -s $LOG_FILE ]; then
    echo "ログファイルは空ではありません。内容を確認中..."
    # ログファイルに通知メッセージが含まれているか確認
    if grep -i "Published calendar notification." $LOG_FILE > /dev/null; then
        echo "テスト成功: 通知メッセージがログに検出されました。"
        exit 0
    else
        echo "テスト失敗: ログに通知メッセージが見つかりません。"
        exit 1
    fi
else
    echo "ログファイルが空か作成されていません。"
    exit 1
fi

