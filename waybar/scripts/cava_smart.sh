#!/bin/bash

# Smart Cava script for Waybar
# Only shows visualization when music is playing

check_music_playing() {
    # Check playerctl first (most reliable for media players)
    if command -v playerctl >/dev/null 2>&1; then
        status=$(playerctl status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            return 0
        fi
    fi
    
    # Check for active audio streams
    if command -v pactl >/dev/null 2>&1; then
        # Get list of playing audio streams
        playing_streams=$(pactl list sink-inputs | grep -c "State: RUNNING")
        if [[ $playing_streams -gt 0 ]]; then
            return 0
        fi
    fi
    
    return 1
}

# If no music is playing, output empty JSON
if ! check_music_playing; then
    echo '{"text": "", "class": "hidden"}'
    # exit 0
fi

# Configure cava
bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i = i + 1))
done

config_file="/tmp/waybar_cava_config"
cat > $config_file << EOF
[general]
bars = 30
framerate = 20

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[smoothing]
monstercat = 1
waves = 0
noise_reduction = 0.77

[color]
gradient = 1
gradient_count = 3
gradient_color_1 = '#94e2d5'
gradient_color_2 = '#89dceb'  
gradient_color_3 = '#74c7ec'
EOF

# Run cava with timeout and check music status periodically
cava -p $config_file 2>/dev/null | while read -r line; do
    if check_music_playing; then
        visualization=$(echo $line | sed $dict)
        echo "{\"text\": \"[ $visualization ]\", \"class\": \"cava-active\"}"
    else
        echo '{"text": "", "class": "hidden"}'
        # break
    fi
done