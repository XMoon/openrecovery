#!/sbin/bash

TAGPREFIX="/tags/."

BACKUP_NAME=`basename "$1"`

echo "Restore Options For $BACKUP_NAME" > "$MENU_FILE"
echo "Go Back:menu:.." >> "$MENU_FILE"
echo "Restore All:shell:nandroid-restore_openrecovery.sh \"$1\" --all" >> "$MENU_FILE"
echo "Restore Selected:shell:nandroid-restore_openrecovery.sh \"$1\"" >> "$MENU_FILE"
echo "Restore All -- no md5:shell:nandroid-restore_openrecovery_withoutmd5.sh \"$1\" --all" >> "$MENU_FILE"
echo "Restore Selected -- no md5:shell:nandroid-restore_openrecovery_withoutmd5.sh \"$1\"" >> "$MENU_FILE"
echo "Options:break:*" >> "$MENU_FILE"
echo "Reboot when finished:tag:nand_rest_autoreboot" >> "$MENU_FILE"
echo "Partitions:break:*" >> "$MENU_FILE"

CWD=$PWD
cd "$1"

for image in system data cache cdrom boot lbl logo ext; do
	if [ `ls $image* 2>/dev/null | wc -l` == 0 ]; then
  	continue
  fi
  
  case $image in
    system)
				echo "System:tag:nand_rest_system" >> "$MENU_FILE"
			;;
    data)
				echo "Data:tag:nand_rest_data" >> "$MENU_FILE"
			;;   
    cache)
				echo "Cache:tag:nand_rest_cache" >> "$MENU_FILE"
			;;   
    cdrom)
				echo "Cdrom:tag:nand_rest_cdrom" >> "$MENU_FILE"
			;;   
    boot)
				echo "Boot:tag:nand_rest_boot" >> "$MENU_FILE"
			;;
    lbl)
				echo "Linux Bootloader:tag:nand_rest_lbl" >> "$MENU_FILE"
			;;
    logo)
				echo "Logo:tag:nand_rest_logo" >> "$MENU_FILE"
			;;
    ext)
				echo "SD Data:tag:nand_rest_ext2" >> "$MENU_FILE"
			;;
  esac
  
done

cd "$PWD"
rm -f "$TAGPREFIX"nand_rest_*
