BACKUP_DIR="$HOME/.config/backup_$(date)"

rm -rf "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 获取当前目录下的所有文件夹
for folder in */ ; do
    # 删除末尾的斜杠
    folder_name="${folder%/}"

    # 如果~/.config/下存在同名文件夹，则备份它
    if [ -d "$HOME/.config/$folder_name" ]; then
        echo "备份 $HOME/.config/$folder_name 到 $BACKUP_DIR/$folder_name"
        # 先删除备份目录中已有的旧备份，避免冲突
        rm -rf "$BACKUP_DIR/$folder_name"
        # 复制整个文件夹到备份目录
        cp -r "$HOME/.config/$folder_name" "$BACKUP_DIR/"
    fi

    # 删除~/.config/中已有的同名文件夹或链接，避免冲突
    rm -rf "$HOME/.config/$folder_name"

    # 创建软链接
    ln -s "$(pwd)/$folder_name" "$HOME/.config/$folder_name"
    echo "已创建软链接 $HOME/.config/$folder_name -> $(pwd)/$folder_name"
done
