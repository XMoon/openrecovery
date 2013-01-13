#!/sbin/sh

CAP=`cat /sys/class/power_supply/battery/charge_counter`
STATUS=`cat /sys/class/power_supply/battery/status`
#Chinese translation
if [ "$STATUS" == "Charging" ]; then
	STATU=充电中
fi
if [ "$STATUS" == "Unknown" ]; then
	STATU=未知
fi
if [ "$STATUS" == "Discharging" ]; then
	STATU=放电中
fi
if [ "$STATUS" == "Not charging" ]; then
	STATU=未充电
fi
if [ "$STATUS" == "Full" ]; then
	STATU=已满
fi
echo "电池电量 - ${CAP}% (${STATU})" > "$MENU_FILE"
echo "返回:menu:.." >> "$MENU_FILE"
