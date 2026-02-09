#!/bin/bash

# Oracle Cloud Agent 清理脚本
# 功能：移除 Oracle Cloud Agent 及相关 snap 包，并清理 snapd

set -e  # 遇到错误立即退出

# 检查并获取 sudo 权限
echo "=== Oracle Cloud Agent 清理脚本 ==="
if [ "$EUID" -ne 0 ]; then
    echo "需要 sudo 权限来执行清理操作"
    echo "正在请求 sudo 权限..."
    sudo -v || {
        echo "错误：无法获取 sudo 权限"
        exit 1
    }
fi

# 检查 snap 是否安装
if ! command -v snap &> /dev/null; then
    echo "警告：snap 未安装，跳过 snap 相关清理"
else
    # 移除 Oracle Cloud Agent 及相关 snap 包
    echo "\n正在移除 Oracle Cloud Agent 及相关 snap 包..."
    
    # 移除 oracle-cloud-agent
    if snap list | grep -q oracle-cloud-agent; then
        echo "- 移除 oracle-cloud-agent"
        sudo snap remove oracle-cloud-agent
    else
        echo "- oracle-cloud-agent 未安装，跳过"
    fi
    
    # 移除 core18
    if snap list | grep -q core18; then
        echo "- 移除 core18"
        sudo snap remove core18
    else
        echo "- core18 未安装，跳过"
    fi
    
    # 移除 lxd
    if snap list | grep -q lxd; then
        echo "- 移除 lxd"
        sudo snap remove lxd
    else
        echo "- lxd 未安装，跳过"
    fi
    
    # 移除 core20
    if snap list | grep -q core20; then
        echo "- 移除 core20"
        sudo snap remove core20
    else
        echo "- core20 未安装，跳过"
    fi
fi

# 清理 snapd
echo "\n正在清理 snapd..."
if command -v apt &> /dev/null; then
    echo "- 自动移除并清理 snapd"
    sudo apt autoremove snapd -y --purge
    
    # 清理 snap 相关目录
    echo "- 清理 snap 相关目录"
    sudo rm -rf /var/cache/snapd/ /var/lib/snapd/ ~/snap/ 2>/dev/null || true
else
    echo "警告：apt 包管理器未找到，跳过 snapd 清理"
fi

# 清理完成
echo "\n=== 清理完成！ ==="
echo "Oracle Cloud Agent 及相关组件已清理"
echo "注意：系统可能需要重启以完全应用更改"
