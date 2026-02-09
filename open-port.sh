#!/bin/bash

# 端口开放脚本
# 功能：设置 iptables 默认策略为 ACCEPT，清空规则，并卸载 netfilter-persistent

set -e  # 遇到错误立即退出

echo "=== 端口开放脚本 ==="

# 检查并获取 sudo 权限
if [ "$EUID" -ne 0 ]; then
    echo "需要 sudo 权限来执行网络配置操作"
    echo "正在请求 sudo 权限..."
    sudo -v || {
        echo "错误：无法获取 sudo 权限"
        exit 1
    }
fi

# 检查 iptables 是否安装
if ! command -v iptables &> /dev/null; then
    echo "警告：iptables 未安装，跳过 iptables 配置"
else
    echo "\n正在配置 iptables..."
    
    # 设置默认策略为 ACCEPT
    echo "- 设置默认策略为 ACCEPT"
    sudo iptables -P INPUT ACCEPT
    sudo iptables -P FORWARD ACCEPT
    sudo iptables -P OUTPUT ACCEPT
    
    # 清空 iptables 规则
    echo "- 清空 iptables 规则"
    sudo iptables -F
    
    echo "- iptables 配置完成"
fi

# 卸载 netfilter-persistent
echo "\n正在清理 netfilter-persistent..."
if command -v apt-get &> /dev/null; then
    if dpkg -l | grep -q netfilter-persistent; then
        echo "- 卸载 netfilter-persistent"
        sudo apt-get purge netfilter-persistent -y
        echo "- 清理完成"
    else
        echo "- netfilter-persistent 未安装，跳过卸载"
    fi
else
    echo "警告：apt-get 包管理器未找到，跳过 netfilter-persistent 清理"
fi

# 清理完成
echo "\n=== 清理完成！ ==="
echo "iptables 规则已清空，默认策略已设置为 ACCEPT"
echo "netfilter-persistent 已清理"
echo "注意：此操作会开放所有端口，请确保在安全环境中使用"
