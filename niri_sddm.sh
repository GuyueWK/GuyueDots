#!/bin/bash

sudo pacman -S --noconfirm sddm

# 设置sddm自动登录niri
# 设置用户名
USERNAME="guyue"

# 启用并启动SDDM服务
sudo systemctl enable sddm
sudo systemctl start sddm

# 创建SDDM自动登录配置目录（如果不存在）
sudo mkdir -p /etc/sddm.conf.d

# 写入自动登录配置文件
sudo sh -c "printf '[Autologin]\nUser=%s\nSession=niri\n' '$USERNAME' > /etc/sddm.conf.d/autologin.conf"

# 确认niri会话文件存在
if [ ! -f /usr/share/wayland-sessions/niri.desktop ] && [ ! -f /usr/share/xsessions/niri.desktop ]; then
    echo "警告：niri.desktop文件不存在，请确认Niri已正确安装，并且对应的会话文件存在于/usr/share/wayland-sessions/或/usr/share/xsessions/。"
else
    echo "niri.desktop会话文件已存在。"
fi

echo "配置完成，请重启系统以验证自动登录和Niri启动效果。"