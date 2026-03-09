#!/bin/bash

# 定義 v4l-utils 所在的目錄
V4L_UTILS_DIR="/mnt/host/source/src/scripts "

echo "start updating v4l-utils..."

# 1. 刪除舊的 v4l-utils 目錄（如果存在）
echo "Deleting v4l-utils: $V4L_UTILS_DIR"
sudo rm -rf "$V4L_UTILS_DIR"

# 2. 複製 v4l-utils 儲存庫
echo "Copying v4l-utils..."
git clone https://git.linuxtv.org/v4l-utils.git/ "$V4L_UTILS_DIR"

# 檢查 git clone 是否成功
if [ $? -ne 0 ]; then
    echo "Git copy fail，please check your internet or permission."
    exit 1
fi

# 3. 進入 v4l-utils 目錄
echo "enter v4l-utils : $V4L_UTILS_DIR"
cd "$V4L_UTILS_DIR"

# 檢查是否成功進入目錄
if [ $? -ne 0 ]; then
    echo "enter v4l-utils failed，please check the path."
    exit 1
fi

# 4. 使用 Meson 建構系統配置專案
echo "Configuring the build..."
meson build/

# 檢查 meson 配置是否成功
if [ $? -ne 0 ]; then
    echo "Meson configuration failed, please make sure Meson and Ninja are installed."
    exit 1
fi

# 5. 使用 Ninja 編譯專案
echo "Compiling..."
ninja -C build/

# 檢查 ninja 編譯是否成功
if [ $? -ne 0 ]; then
    echo "Ninja compilation failed."
    exit 1
fi

# 6. 安裝編譯好的檔案
echo "Installing..."
sudo ninja -C build/ install

# 檢查安裝是否成功
if [ $? -ne 0 ]; then
    echo "Installation failed, please check permissions or dependencies."
    exit 1
fi

# 7. 
# echo "進入 edid-decode 工具目錄..."
# cd /home/ah/v4l-utils/build/utils/edid-decode

# 檢查是否成功進入目錄
# if [ $? -ne 0 ]; then
#     echo "無法進入 build/utils/edid-decode 目錄。"
    # 但不終止腳本，因為核心安裝可能已完成
# fi

echo "Update Complete！"


