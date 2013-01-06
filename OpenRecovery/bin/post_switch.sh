#!/sbin/bash

mkdir /cdrom
chmod 0755 /cdrom

#set fstab
	MTDBLOCK_SYSTEM=$(/sbin/cat /proc/mtd | /sbin/grep "system")
	MTDBLOCK_SYSTEM=${MTDBLOCK_SYSTEM%%:*}
	MTDBLOCK_SYSTEM=${MTDBLOCK_SYSTEM##mtd}
	MTDBLOCK_SYSTEM="\/dev\/block\/mtdblock$MTDBLOCK_SYSTEM"

	MTDBLOCK_DATA=$(/sbin/cat /proc/mtd | /sbin/grep "userdata")
	MTDBLOCK_DATA=${MTDBLOCK_DATA%%:*}
	MTDBLOCK_DATA=${MTDBLOCK_DATA##mtd}
	MTDBLOCK_DATA="\/dev\/block\/mtdblock$MTDBLOCK_DATA"

	MTDBLOCK_CDROM=$(/sbin/cat /proc/mtd | /sbin/grep "cdrom")
	MTDBLOCK_CDROM=${MTDBLOCK_CDROM%%:*}
	MTDBLOCK_CDROM=${MTDBLOCK_CDROM##mtd}
	MTDBLOCK_CDROM="\/dev\/block\/mtdblock$MTDBLOCK_CDROM"

	MTDBLOCK_CACHE=$(/sbin/cat /proc/mtd | /sbin/grep "cache")
	MTDBLOCK_CACHE=${MTDBLOCK_CACHE%%:*}
	MTDBLOCK_CACHE=${MTDBLOCK_CACHE##mtd}
	MTDBLOCK_CACHE="\/dev\/block\/mtdblock$MTDBLOCK_CACHE"

	sed -i "s/MTDBLOCKSYSTEM/$MTDBLOCK_SYSTEM/g" /etc/fstab
	sed -i "s/MTDBLOCKDATA/$MTDBLOCK_DATA/g" /etc/fstab
	sed -i "s/MTDBLOCKCDROM/$MTDBLOCK_CDROM/g" /etc/fstab
	sed -i "s/MTDBLOCKCACHE/$MTDBLOCK_CACHE/g" /etc/fstab

#set display brightness
if [ -f /sdcard/OpenRecovery/etc/brightness ] ; then
    cat /sdcard/OpenRecovery/etc/brightness > /sys/class/leds/lcd-backlight/brightness
fi
# toggle adb function to get correct initial usb state 
echo 0 > /sys/class/usb_composite/adb/enable 
echo 1 > /sys/class/usb_composite/adb/enable
killall -9 recovery

#then continue with the remains
killall -9 sleep
killall -9 updater
