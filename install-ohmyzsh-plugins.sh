#!/bin/bash

# Oh My Zsh 插件安装脚本
# 功能：安装 zsh-autosuggestions、zsh-syntax-highlighting 和 zsh-history-substring-search 插件并配置到 .zshrc

set -e  # 遇到错误立即退出

echo "=== Oh My Zsh 插件安装脚本 ==="

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
    echo "错误：git 未安装，请先安装 git"
    exit 1
fi

# 检查 Oh My Zsh 是否安装
if [ ! -d "${ZSH:-~/.oh-my-zsh}" ]; then
    echo "错误：Oh My Zsh 未安装，请先安装 Oh My Zsh"
    exit 1
fi

# 安装 zsh-autosuggestions 插件
echo "\n正在安装 zsh-autosuggestions 插件..."
PLUGIN_DIR="${ZSH:-~/.oh-my-zsh}/plugins/zsh-autosuggestions"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-autosuggestions 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-autosuggestions 仓库"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 安装 zsh-syntax-highlighting 插件
echo "\n正在安装 zsh-syntax-highlighting 插件..."
PLUGIN_DIR="${ZSH:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-syntax-highlighting 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-syntax-highlighting 仓库"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 安装 zsh-history-substring-search 插件
echo "\n正在安装 zsh-history-substring-search 插件..."
PLUGIN_DIR="${ZSH:-~/.oh-my-zsh}/plugins/zsh-history-substring-search"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-history-substring-search 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-history-substring-search 仓库"
    git clone https://github.com/zsh-users/zsh-history-substring-search "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 配置 .zshrc 文件
echo "\n正在配置 .zshrc 文件..."

# 明确指定 .zshrc 文件路径
ZSHRC_FILE="~/.zshrc"

# 展开 ~ 为实际路径
ZSHRC_FILE="$(eval echo "$ZSHRC_FILE")"

# 检查 ZSHRC_FILE 是否设置
if [ -z "$ZSHRC_FILE" ]; then
    echo "错误：ZSHRC_FILE 未设置"
    exit 1
fi

# 检查 .zshrc 文件是否存在
if [ ! -f "$ZSHRC_FILE" ]; then
    echo "错误：.zshrc 文件不存在"
    exit 1
fi

# 检查并修改 plugins 数组
# 定义需要添加的插件列表
PLUGINS_TO_ADD=("zsh-autosuggestions" "zsh-syntax-highlighting" "zsh-history-substring-search")

# 遍历需要添加的插件
for PLUGIN in "${PLUGINS_TO_ADD[@]}"; do
    # 读取当前的 plugins 行
    PLUGINS_LINE=$(grep -E '^plugins=\(' "$ZSHRC_FILE")
    
    # 检查 plugins 行是否存在
    if [ -z "$PLUGINS_LINE" ]; then
        echo "错误：未找到 plugins 数组定义"
        exit 1
    fi
    
    # 提取当前的插件列表
    CURRENT_PLUGINS=$(echo "$PLUGINS_LINE" | sed 's/plugins=(//; s/)/\n/; s/\s\+/\n/g' | grep -v '^$')
    
    # 检查插件是否已存在
    if echo "$CURRENT_PLUGINS" | grep -q "$PLUGIN"; then
        echo "- $PLUGIN 已在 plugins 数组中，跳过配置"
    else
        echo "- 在 plugins 数组中添加 $PLUGIN"
        
        # 检查 plugins 行的格式
        if echo "$PLUGINS_LINE" | grep -q ')$'; then
            # 如果 plugins 行以 ) 结尾，在 ) 前添加插件
            NEW_PLUGINS_LINE=$(echo "$PLUGINS_LINE" | sed "s/)/ $PLUGIN)/")
        else
            # 否则，在行尾添加插件
            NEW_PLUGINS_LINE="$PLUGINS_LINE $PLUGIN"
        fi
        
        # 替换 plugins 行
        sed -i "s/^plugins=\(.*\)/$NEW_PLUGINS_LINE/" "$ZSHRC_FILE"
        echo "- 配置完成"
    fi
done

# 安装完成提示
echo "\n=== 安装完成！ ==="
echo "zsh-autosuggestions、zsh-syntax-highlighting 和 zsh-history-substring-search 插件已安装并配置"
echo "\n使用说明："
echo "1. 重新启动终端或运行 'source ~/.zshrc' 以应用更改"
echo "2. 开始输入命令时，将自动显示命令建议（zsh-autosuggestions）"
echo "3. 命令将自动进行语法高亮显示（zsh-syntax-highlighting）"
echo "4. 按右箭头键接受命令建议"
echo "5. 输入命令的任意部分后，按上下箭头键搜索历史命令（zsh-history-substring-search）"
echo "\n插件功能说明："
echo "- zsh-autosuggestions：根据历史命令自动提示"
echo "- zsh-syntax-highlighting：提供命令语法高亮，增强可读性"
echo "- zsh-history-substring-search：通过输入命令的任意部分搜索历史命令，按上下箭头键切换匹配结果"
