#!/bin/bash

cp Backup/grub /etc/sysconfig/grub

rm /sbin/vfio-pci-override-vga.sh

rm /etc/modprobe.d/local.conf

rm /etc/dracut.conf.d/local.conf

grub2-mkconfig -o /etc/grub2-efi.cfg

dracut -f --kver `uname -r`
