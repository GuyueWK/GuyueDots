#!/bin/bash

# 中文目录和对应英文目录名
declare -A folders=(
    ["下载"]="Downloads"
    ["公共"]="Public"
    ["图片"]="Pictures"
    ["文档"]="Documents"
    ["桌面"]="Desktop"
    ["模板"]="Templates"
    ["视频"]="Videos"
    ["音乐"]="Music"
)

config_file="$HOME/.config/user-dirs.dirs"
backup_file="$HOME/.config/user-dirs.dirs.bak"

cd "$HOME" || exit

# 重命名目录
for cn_name in "${!folders[@]}"; do
    en_name=${folders[$cn_name]}
    if [ -d "$cn_name" ]; then
        mv -v "$cn_name" "$en_name"
    else
        echo "目录 \"$cn_name\" 不存在，跳过"
    fi
done

# 备份配置文件
if [ -f "$config_file" ]; then
    cp -v "$config_file" "$backup_file"
else
    echo "配置文件不存在，创建新文件"
    touch "$config_file"
fi

# 修改配置文件中的路径为英文
temp_file=$(mktemp)
while IFS= read -r line; do
    modified_line="$line"
    for cn_name in "${!folders[@]}"; do
        en_name=${folders[$cn_name]}
        modified_line=$(echo "$modified_line" | sed "s|\$HOME/$cn_name|\$HOME/$en_name|g")
    done
    echo "$modified_line" >> "$temp_file"
done < "$config_file"

mv "$temp_file" "$config_file"
echo "已更新 $config_file，备份存为 $backup_file"

# 刷新用户目录设置
xdg-user-dirs-update

echo "操作完成！"

