pkill yakuake
xrandr --output VGA1 --mode 1920x1200
xrandr --output LVDS1 --off
xrandr --output HDMI1 --mode 1920x1200 --left-of VGA1
sleep 2
yakuake &
