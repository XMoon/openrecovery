#!/sbin/sh

CAP=`cat /sys/class/power_supply/battery/charge_counter`
STATUS=`cat /sys/class/power_supply/battery/status`
echo "Battery - ${CAP}% (${STATUS})" > "$MENU_FILE"
echo "Go Back:menu:.." >> "$MENU_FILE"
echo "*:break:*" >> "$MENU_FILE"
echo "Wipe Battery Status:shell:wipe_battery.sh" >> "$MENU_FILE"
