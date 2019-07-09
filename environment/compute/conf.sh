#!/bin/bash
 
# Install packages
echo "[TASK 1] Install packages"
sudo apt-get update -yq >/dev/null 2>&1
sudo apt-get install -yq build-essential linux-headers-$(uname -r) unzip p7zip-full linux-image-extra-virtual python3-pip >/dev/null 2>&1
pip3 install psutil 
 
# Configure blacklist-nouveau.conf
echo "[TASK 2] Configure blacklist-nouveau.conf"
sudo touch /etc/modprobe.d/blacklist-nouveau.conf
sudo bash -c "echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'blacklist lbm-nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'alias nouveau off' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'alias lbm-nouveau off' >> /etc/modprobe.d/blacklist-nouveau.conf"
 
# Configure nouveau-kms.conf
echo "[TASK 3] Configure nouveau-kms.conf"
sudo touch /etc/modprobe.d/nouveau-kms.conf
sudo bash -c "echo 'options nouveau modeset=0' >>  /etc/modprobe.d/nouveau-kms.conf"
sudo update-initramfs -u
 
# Install NVIDIA
echo "[TASK 4] Install NVIDIA"
wget http://us.download.nvidia.com/tesla/410.104/NVIDIA-Linux-x86_64-410.104.run
sudo /bin/bash NVIDIA-Linux-x86_64-410.104.run --ui=none --no-questions --silent -X
 
# Install HashCat
echo "[TASK 5] Install HashCat"
git clone https://github.com/hashcat/hashcat.git
sudo make
sudo make install
 
# Reboot system
echo "[TASK 6] Reboot system"
sudo reboot