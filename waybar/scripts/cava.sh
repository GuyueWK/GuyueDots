#! /bin/bash

# Check if any audio is playing
check_audio() {
    # Method 1: Check MPRIS players
    if command -v playerctl >/dev/null 2>&1; then
        status=$(playerctl status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            return 0
        fi
    fi
    
    # Method 2: Check PulseAudio/PipeWire running sinks
    if command -v pactl >/dev/null 2>&1; then
        # Check if any sink input is running (audio being played)
        sink_inputs=$(pactl list sink-inputs short 2>/dev/null | wc -l)
        if [[ $sink_inputs -gt 0 ]]; then
            return 0
        fi
    fi
    
    # Method 3: Check WirePlumber (if available)
    if command -v wpctl >/dev/null 2>&1; then
        # Check if default sink has active streams
        active_streams=$(wpctl status | grep -A 20 "Audio" | grep "├─" | grep -v "vol:" | wc -l)
        if [[ $active_streams -gt 0 ]]; then
            return 0
        fi
    fi
    
    return 1
}

# If no audio is playing, exit with empty output
if ! check_audio; then
    echo ""
    exit 0
fi

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i = i + 1))
done

# write cava config
config_file="/tmp/waybar_cava_config"
echo "
[general]
bars = 12
framerate = 30

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[smoothing]
monstercat = 1
waves = 0
" >$config_file

# read stdout from cava
timeout 1 cava -p $config_file | while read -r line; do
  if check_audio; then
    echo $line | sed $dict
  else
    echo ""
    break
  fi
done
