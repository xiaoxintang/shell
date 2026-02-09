#!/bin/bash

# 检查 curl 是否安装
if ! command -v curl &> /dev/null; then
    echo "错误：curl 未安装，请先安装 curl"
    exit 1
fi

# 检查 sudo 权限
if ! sudo -n true 2>/dev/null; then
    echo "警告：需要 sudo 权限，请确保您有管理员权限"
fi

# 下载 Oh My Zsh 安装脚本
echo "正在下载 Oh My Zsh 安装脚本..."
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install-ohmyzsh.sh

# 检查下载是否成功
if [ ! -f "install-ohmyzsh.sh" ]; then
    echo "错误：下载安装脚本失败"
    exit 1
fi

# 运行安装脚本
echo "正在安装 Oh My Zsh..."
sudo sh install-ohmyzsh.sh

# 清理临时文件
rm -f install-ohmyzsh.sh

echo "Oh My Zsh 安装完成！"

