#!/bin/bash

# Script to restore original gruvbox theme colors
# Run this script if you want to revert back to the original brown/yellow theme

echo "Restoring original gruvbox theme colors..."

# Restore gruvbox.conf
cat > /home/guyue/github/GuyueDots/hypr/gruvbox.conf << 'EOF'
$border_active = rgb(BFAA80)
$border_inactive = rgb(2C2A24)
$text = rgb(DDD5C4)
$borders = rgb(A0907A)
$focused = rgb(D08B57)
$focused2 = rgb(BFAA80)
$color1 = rgb(7699A3)
$color2 = rgb(8D7AAE)
$color3 = rgb(78997A)
$urgent = rgb(B05A5A)
EOF

# Restore waybar colors
sed -i 's/@define-color background #1e1e2e;/@define-color background #2C2A24;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color second-background #313244;/@define-color second-background #3A372F;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color text #cdd6f4;/@define-color text #DDD5C4;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color borders #6c7086;/@define-color borders #A0907A;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color focused #f38ba8;/@define-color focused #D08B57;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color focused2 #cba6f7;/@define-color focused2 #BFAA80;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color color1 #89b4fa;/@define-color color1 #7699A3;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color color2 #cba6f7;/@define-color color2 #8D7AAE;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color color3 #a6e3a1;/@define-color color3 #78997A;/' /home/guyue/github/GuyueDots/waybar/style.css
sed -i 's/@define-color urgent #f38ba8;/@define-color urgent #B05A5A;/' /home/guyue/github/GuyueDots/waybar/style.css

echo "Original gruvbox theme restored! You may need to restart Hyprland and Waybar to see the changes."