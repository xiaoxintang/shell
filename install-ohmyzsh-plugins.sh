#!/bin/bash

# Oh My Zsh 插件安装脚本
# 功能：安装 zsh-autosuggestions 插件并配置到 .zshrc

set -e  # 遇到错误立即退出

echo "=== Oh My Zsh 插件安装脚本 ==="

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
    echo "错误：git 未安装，请先安装 git"
    exit 1
fi

# 检查 Oh My Zsh 是否安装
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}" ]; then
    echo "错误：Oh My Zsh 未安装，请先安装 Oh My Zsh"
    exit 1
fi

# 安装 zsh-autosuggestions 插件
echo "\n正在安装 zsh-autosuggestions 插件..."
PLUGIN_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-autosuggestions 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-autosuggestions 仓库"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 安装 zsh-syntax-highlighting 插件
echo "\n正在安装 zsh-syntax-highlighting 插件..."
PLUGIN_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-syntax-highlighting 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-syntax-highlighting 仓库"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 安装 zsh-history-substring-search 插件
echo "\n正在安装 zsh-history-substring-search 插件..."
PLUGIN_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"

if [ -d "$PLUGIN_DIR" ]; then
    echo "- zsh-history-substring-search 插件已存在，跳过安装"
else
    echo "- 克隆 zsh-history-substring-search 仓库"
    git clone https://github.com/zsh-users/zsh-history-substring-search "$PLUGIN_DIR"
    echo "- 插件安装完成"
fi

# 配置 .zshrc 文件
echo "\n正在配置 .zshrc 文件..."
ZSHRC_FILE="~/.zshrc"

# 展开 ~ 为实际路径
ZSHRC_FILE="$(eval echo "$ZSHRC_FILE")"

if [ ! -f "$ZSHRC_FILE" ]; then
    echo "错误：.zshrc 文件不存在"
    exit 1
fi

# 检查并添加 zsh-autosuggestions 到 plugins 数组
if grep -q "zsh-autosuggestions" "$ZSHRC_FILE"; then
    echo "- zsh-autosuggestions 已在 plugins 数组中，跳过配置"
else
    echo "- 在 plugins 数组中添加 zsh-autosuggestions"
    
    # 使用 sed 命令在 plugins 数组中添加 zsh-autosuggestions
    # 查找 plugins=( 行，在其后添加 zsh-autosuggestions
    sed -i '' '/^plugins=(/a\
    zsh-autosuggestions' "$ZSHRC_FILE"
    
    echo "- 配置完成"
fi

# 检查并添加 zsh-syntax-highlighting 到 plugins 数组
if grep -q "zsh-syntax-highlighting" "$ZSHRC_FILE"; then
    echo "- zsh-syntax-highlighting 已在 plugins 数组中，跳过配置"
else
    echo "- 在 plugins 数组中添加 zsh-syntax-highlighting"
    
    # 使用 sed 命令在 plugins 数组中添加 zsh-syntax-highlighting
    # 查找 plugins=( 行，在其后添加 zsh-syntax-highlighting
    sed -i '' '/^plugins=(/a\
    zsh-syntax-highlighting' "$ZSHRC_FILE"
    
    echo "- 配置完成"
fi

# 检查并添加 zsh-history-substring-search 到 plugins 数组
if grep -q "zsh-history-substring-search" "$ZSHRC_FILE"; then
    echo "- zsh-history-substring-search 已在 plugins 数组中，跳过配置"
else
    echo "- 在 plugins 数组中添加 zsh-history-substring-search"
    
    # 使用 sed 命令在 plugins 数组中添加 zsh-history-substring-search
    # 查找 plugins=( 行，在其后添加 zsh-history-substring-search
    sed -i '' '/^plugins=(/a\
    zsh-history-substring-search' "$ZSHRC_FILE"
    
    echo "- 配置完成"
fi

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
