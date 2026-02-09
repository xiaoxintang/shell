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

# 下载 Docker 安装脚本
echo "正在下载 Docker 安装脚本..."
curl -fsSL https://get.docker.com -o get-docker.sh

# 检查下载是否成功
if [ ! -f "get-docker.sh" ]; then
    echo "错误：下载安装脚本失败"
    exit 1
fi

# 运行安装脚本
echo "正在安装 Docker..."
sudo sh get-docker.sh

# 将当前用户添加到 docker 组
echo "\n正在将当前用户添加到 docker 组..."
CURRENT_USER=$(whoami)
sudo usermod -aG docker "$CURRENT_USER"
echo "- 当前用户 $CURRENT_USER 已添加到 docker 组"
echo "- 注意：需要重新登录或重启终端才能生效"

# 清理临时文件
rm -f get-docker.sh

echo "\nDocker 安装完成！"
echo "使用说明："
echo "1. 重新登录或重启终端以应用 docker 组权限"
echo "2. 测试 Docker 是否正常运行：docker run hello-world"
echo "3. 查看 Docker 版本：docker --version"