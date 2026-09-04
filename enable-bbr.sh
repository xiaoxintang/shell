#!/bin/bash

# Ubuntu BBR 开启脚本
# 功能：写入缺失的 BBR 配置，应用 sysctl 配置并显示生效结果

set -e

CONFIG_FILE="/etc/sysctl.d/99-bbr.conf"
BBR_CONFIGS=(
    "net.core.default_qdisc=fq"
    "net.ipv4.tcp_congestion_control=bbr"
)

echo "=== Ubuntu BBR 开启脚本 ==="

# 检查并获取 sudo 权限
if [ "$EUID" -ne 0 ]; then
    echo "需要 sudo 权限来修改系统网络配置"
    echo "正在请求 sudo 权限..."
    sudo -v || {
        echo "错误：无法获取 sudo 权限"
        exit 1
    }
fi

# 以 root 权限执行命令，同时兼容未安装 sudo 的 root 环境
run_as_root() {
    if [ "$EUID" -eq 0 ]; then
        "$@"
    else
        sudo "$@"
    fi
}

# 先查看现有配置
echo
echo "正在查看 $CONFIG_FILE："
if run_as_root test -f "$CONFIG_FILE"; then
    echo "----------------------------------------"
    run_as_root cat "$CONFIG_FILE"
    echo "----------------------------------------"
else
    echo "- 配置文件不存在，将创建该文件"
    run_as_root touch "$CONFIG_FILE"
fi

# 仅添加尚未存在的配置，避免重复写入
for CONFIG in "${BBR_CONFIGS[@]}"; do
    if run_as_root awk -v expected="$CONFIG" '
        {
            line = $0
            sub(/[[:space:]]*#.*/, "", line)
            gsub(/[[:space:]]/, "", line)
            if (line == expected) {
                found = 1
            }
        }
        END { exit !found }
    ' "$CONFIG_FILE"; then
        echo "- 配置已存在，跳过：$CONFIG"
    else
        # 开头保留换行，避免原文件末尾无换行符时与旧配置粘连
        printf '\n%s\n' "$CONFIG" | run_as_root tee -a "$CONFIG_FILE" > /dev/null
        echo "- 已添加配置：$CONFIG"
    fi
done

# 应用并检查配置
echo
echo "正在应用 sysctl 配置..."
run_as_root sysctl --system

echo
echo "BBR 配置检查结果："
sysctl net.ipv4.tcp_congestion_control
sysctl net.core.default_qdisc

echo
echo "=== BBR 配置完成 ==="
