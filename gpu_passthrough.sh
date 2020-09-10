echo "Installing required packages"

dnf groupinstall "Virtualization Host" -y

dnf install virt-install virt-manager -y


if ! [ -a Backup ]
        then
                mkdir Backup
fi

cp /etc/sysconfig/grub Backup/grub     


echo "Edit grub: intel_iommu=on or amd_iommu=on rd.driver.pre=vfio-pci kvm.ignore_msrs=1"

vi /etc/sysconfig/grub

echo "Updating grub"

grub2-mkconfig -o /etc/grub2-efi.cfg

echo "Getting GPU passthrough scripts ready"

cp vfio-pci-override-vga.sh /sbin/vfio-pci-override-vga.sh

chmod 755 /sbin/vfio-pci-override-vga.sh

echo "install vfio-pci /sbin/vfio-pci-override-vga.sh" > /etc/modprobe.d/local.conf

cp local.conf /etc/dracut.conf.d/local.conf

echo "Generating initramfs"

dracut -f --kver `uname -r`
