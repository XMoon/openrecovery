#!/sbin/bash

export PATH="$PATH:/bin:/sbin:/or/bin:/or/sbin"

# arguments
# $1 the phone suffix
#
# SHOLS - Milestone (A853, XT702)
# STCU  - Sholes Tablet (XT701)
# STR   - Milestone XT720 (XT720)
# JRD   - Defy (MB525) - not implemented yet
# STAB  - Milestone 2 (A953) - not implemented yet

#flags
#===============================================================================

INSTALL_COMMAND=0
ROOT="/"

#post-installation
#===============================================================================

#put the command into the cache - if it doesn't exist
if [ $INSTALL_COMMAND -eq 1 ]; then
	if [ ! -f /cache/recovery/command ]; then
		cp -f /or/etc/command /cache/recovery/command
		chmod 0644 /cache/recovery/command
	fi
fi

#basic initialization
#===============================================================================

#dirs

mkdir /cdrom
chmod 0755 /cdrom

#fstab
cp -f "/or/etc/fstab.$1" ${ROOT}etc/fstab
chmod 0644 ${ROOT}etc/fstab

cp -f /or/etc/mtab ${ROOT}etc/mtab
chmod 0644 ${ROOT}etc/mtab

#bash etc
mkdir ${ROOT}etc/bash
chmod 0644 ${ROOT}etc/bash

cp -f "/or/etc/bash/bashrc.$1" ${ROOT}etc/bash/bashrc
chmod 0644 ${ROOT}etc/bash/bashrc

#bash - check if colors are disabled
if [ -f /or/etc/bash/.nobashcolors ]; then
	cp -f /or/etc/bash/.nobashcolors ${ROOT}etc/bash/.nobashcolors
	chmod 0644 ${ROOT}etc/bash/.nobashcolors
fi

#our little timezone hack
cp -f /or/etc/timezone ${ROOT}etc/timezone
chmod 0644 ${ROOT}etc/timezone

#keyboard layout
cp -f /or/etc/keyboard ${ROOT}etc/keyboard
chmod 0644 ${ROOT}etc/keyboard

# Patch fstab
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

#terminfo
cp -fR /or/etc/terminfo/ ${ROOT}etc
chmod -R 0644 ${ROOT}etc/terminfo

cp -f /or/sbin/usbd ${ROOT}sbin/usbd
chmod 0755 ${ROOT}sbin/usbd

cp -f /or/sbin/battd ${ROOT}sbin/battd
chmod 0755 ${ROOT}sbin/battd

cp -f /or/sbin/linker ${ROOT}sbin/linker
chmod 0755 ${ROOT}sbin/linker

cp -f /or/sbin/sshot ${ROOT}sbin/sshot
chmod 0755 ${ROOT}sbin/sshot

#Nandroid
cp -f /or/sbin/dump_image-or ${ROOT}sbin/dump_image-or
chmod 0755 ${ROOT}sbin/dump_image-or
ln -s /sbin/dump_image-or ${ROOT}sbin/dump_image
chmod 0755 dump_image

cp -f /or/sbin/e2fsck ${ROOT}sbin/e2fsck
chmod 0755 ${ROOT}sbin/e2fsck

cp -f /or/sbin/fsck_msdos ${ROOT}sbin/fsck_msdos
chmod 0755 ${ROOT}sbin/fsck_msdos

cp -f /or/sbin/tune2fs ${ROOT}sbin/tune2fs
chmod 0755 ${ROOT}sbin/tune2fs

cp -f /or/sbin/parted ${ROOT}sbin/parted
chmod 0755 ${ROOT}sbin/parted

cp -f /or/sbin/erase_image-or ${ROOT}sbin/erase_image-or
chmod 0755 ${ROOT}sbin/erase_image-or
ln -s /sbin/erase_image-or ${ROOT}sbin/erase_image
chmod 0755 erase_image

cp -f /or/sbin/flash_image-or ${ROOT}sbin/flash_image-or
chmod 0755 ${ROOT}sbin/flash_image-or
ln -s /sbin/flash_image-or ${ROOT}sbin/flash_image
chmod 0755 flash_image

cp -f /or/sbin/mkyaffs2image-or ${ROOT}sbin/mkyaffs2image-or
chmod 0755 ${ROOT}sbin/mkyaffs2image-or
ln -s /sbin/mkyaffs2image-or ${ROOT}sbin/mkyaffs2image
chmod 0755 mkyaffs2image

cp -f /or/sbin/unyaffs-or ${ROOT}sbin/unyaffs-or
chmod 0755 ${ROOT}sbin/unyaffs-or
ln -s /sbin/unyaffs-or ${ROOT}sbin/unyaffs
chmod 0755 unyaffs

#Updater
cp -f /or/sbin/updater-or ${ROOT}sbin/updater-or
chmod 0755 ${ROOT}sbin/updater-or
rm -f ${ROOT}sbin/updater
ln -s /sbin/updater-or ${ROOT}sbin/updater
chmod 0755 /sbin/updater
cp -f /or/sbin/script-updater ${ROOT}sbin/script-updater
chmod 0755 ${ROOT}sbin/script-updater

#Interactive menu
cp -f /or/sbin/imenu ${ROOT}sbin/imenu
chmod 0755 ${ROOT}sbin/imenu

#adbd
cp -f /or/sbin/adbd_bash ${ROOT}sbin/adbd
chmod 0755 ${ROOT}sbin/adbd

#create a bin folder for the scripts
cp -fR /or/bin/ $ROOT
chmod -R 0755 ${ROOT}bin

#remove self copy
rm ${ROOT}bin/switch.sh

#lib and modules
mkdir ${ROOT}lib
cp -fR /or/lib/ $ROOT
chmod -R 0644 ${ROOT}lib

#ext2/3/4 partition on sdcard
if [ -b /dev/block/mmcblk0p2 ]; then
	mkdir /sddata
	chmod 0755 /sddata
	ln -s /sddata /sd-ext
	insmod "${ROOT}lib/modules/jbd2.ko"
	insmod "${ROOT}lib/modules/ext4.ko"
	echo "/dev/block/mmcblk0p2          /sddata         auto            defaults        0 0" >> /etc/fstab
	e2fsck -p /dev/block/mmcblk0p2
	mount /sddata
fi

#res - read the theme first
rm -fR /res

if [ -f /or/etc/theme ]; then
	cp -f /or/etc/theme ${ROOT}etc/theme
	chmod 0644 ${ROOT}etc/theme
	
	THEME=`awk 'NR==1' ${ROOT}etc/theme`
	
	if [ -d /or/$THEME ]; then
		cp -fR /or/$THEME/ $ROOT
		mv -f ${ROOT}${THEME} ${ROOT}res
	else
		cp -fR /or/res.or/ $ROOT
		mv -f ${ROOT}res.or ${ROOT}res
	fi
else
	cp -fR /or/res.or/ $ROOT
	mv -f ${ROOT}res.or ${ROOT}res
fi

chmod -R 0644 ${ROOT}res

#menus
mkdir ${ROOT}menu
chmod 0644 ${ROOT}menu
export MENU_DIR=${ROOT}menu
cp -fR /or/menu/ $ROOT

#tags
mkdir ${ROOT}tags
chmod 0644 ${ROOT}tags
cp -fR /or/tags/ $ROOT


#Launch Open Recovery
#==============================================================================


cp -f "/or/sbin/open_rcvr."$1 ${ROOT}sbin/recovery
chmod 0755 ${ROOT}sbin/recovery

overclock.sh

#Check if we are supposed to call 2nd-init or just restart the binaries
if [ -d "/or/2ndinit.$1" ]; then
	DIR="/or/2ndinit.$1"
	
	cp -f "$DIR/default.prop" /default.prop
	chmod 0644 /default.prop
		
	cp -f "$DIR/init.rc" /init.rc
	chmod 0755 init.rc
							
	#2nd-init (new init script will kill old adb and recovery)
	#don't use exec, the primary recovery would finish too soon
	/or/sbin/2nd-init
	
else
	
	#just call post_switch.sh
	post_switch.sh
	
fi
