#!/bin/bash

# デフォルトでホームディレクトリを指定
dir=~
[ "$1" != "" ] && dir="$1"  # 引数が指定されていれば、使用するディレクトリを変更

# ros2_ws ディレクトリに移動してビルド
cd $dir/ros2_ws
colcon build --symlink-install

# ROS 2 Foxy のセットアップを適用
source /opt/ros/foxy/setup.bash
source $dir/ros2_ws/install/setup.bash

# mypkg のシステムステータスを取得
timeout 10 ros2 run mypkg system_status > /tmp/mypkg.log

# /system_status_publisher トピックを監視
timeout 10 ros2 topic echo /system_status_publisher > /tmp/topic_output.log &

# ログファイルの内容を表示
cat /tmp/mypkg.log

# トピック出力ログから "CPU" と "Memory" の情報を抽出
cat /tmp/topic_output.log | grep "CPU"
cat /tmp/topic_output.log | grep "Memory"

