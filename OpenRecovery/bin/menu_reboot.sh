#!/sbin/bash

echo "Reboot Mode" > "$MENU_FILE"
echo "Back:menu:.." >> "$MENU_FILE"
echo "*:break:*" >> "$MENU_FILE"
echo "Shutdown:shell:halt.sh" >> "$MENU_FILE"
echo "Bootloader:shell:reboot-btl.sh" >> "$MENU_FILE"
echo "Recovery:shell:reboot-rcvr.sh" >> "$MENU_FILE"
