run:
	sudo qemu-system-aarch64 \
		-machine raspi3b \
		-cpu cortex-a53 \
		-smp 4 \
		-m 1G \
		-kernel kernel8.img \
		-dtb bcm2710-rpi-3-b.dtb \
		-sd 2023-05-03-raspios-bullseye-armhf-lite.img \
		-append "root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
		-usbdevice keyboard \
		-usbdevice mouse \
		-device usb-net,netdev=net0 \
		-netdev user,id=net0,hostfwd=tcp::2022-:22

ssh:
	ssh edge@localhost -p 2022

init:
	wget https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2023-05-03/2023-05-03-raspios-bullseye-armhf-lite.img.xz
	unxz 2023-05-03-raspios-bullseye-armhf-lite.img.xz
	qemu-img resize 2023-05-03-raspios-bullseye-armhf-lite.img 16G
