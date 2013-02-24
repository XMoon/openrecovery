#!/sbin/bash

echo "Installing su..."

cp -f /sdcard/OpenRecovery/root/su /system/bin/su
chmod 6755 /system/bin/su

echo "Installing Superuser.apk..."

cp -f /sdcard/OpenRecovery/root/SuperUser.apk /system/app/SuperUser.apk
chmod 0644 /system/app/SuperUser.apk

if [ -f /system/bin/su ]; then
	rm -f /system/xbin/su
fi
