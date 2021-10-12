#!/bin/bash

echo " "
echo "***** initial install *****"
echo " "

echo "[TASK $((++count))] updating system"
sudo apt update >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1

echo "[TASK $((++count))] intalling initial packages"
sudo apt install -y --ignore-missing build-essential tmux htop vim jq unzip lsof git p7zip-full >/dev/null 2>&1

echo "[TASK $((++count))] setting timezone"
sudo bash -c "ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime"

echo "[TASK $((++count))] configuring blacklist-neuveau"
sudo touch /etc/modprobe.d/blacklist-nouveau.conf
sudo bash -c "echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'blacklist lbm-nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'alias nouveau off' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'alias lbm-nouveau off' >> /etc/modprobe.d/blacklist-nouveau.conf"

echo "[TASK $((++count))] appling nouveau"
sudo touch /etc/modprobe.d/nouveau-kms.conf
sudo bash -c "echo 'options nouveau modeset=0' >>  /etc/modprobe.d/nouveau-kms.conf"
sudo update-initramfs -u >/dev/null 2>&1
echo " "
echo "done! please reboot your server"
echo " "
