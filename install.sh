# 安装必要程序
sudo pacman -S --noconfirm zen-browser-bin fcitx5-im fcitx5-rime waybar kitty wofi swappy yazi wlogout swaync blueman wl-clipboard swww clapper cliphist
paru -S --noconfirm ttf-iosevka-nerd zathura visual-studio-code-bin btop fastfetch cava

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


# 设置sddm自动登录niri
# 设置用户名
USERNAME="guyue"

# 启用并启动SDDM服务
sudo systemctl enable sddm
sudo systemctl start sddm

# 创建SDDM自动登录配置目录（如果不存在）
sudo mkdir -p /etc/sddm.conf.d

# 写入自动登录配置文件
sudo tee /etc/sddm.conf.d/autologin.conf > /dev/null <<EOF
[Autologin]
User=$USERNAME
Session=niri
EOF

# 确认niri会话文件存在
if [ ! -f /usr/share/wayland-sessions/niri.desktop ] && [ ! -f /usr/share/xsessions/niri.desktop ]; then
    echo "警告：niri.desktop文件不存在，请确认Niri已正确安装，并且对应的会话文件存在于/usr/share/wayland-sessions/或/usr/share/xsessions/。"
else
    echo "niri.desktop会话文件已存在。"
fi

echo "配置完成，请重启系统以验证自动登录和Niri启动效果。"
