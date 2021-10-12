#!/bin/bash

echo " "
echo "***** hashcat install *****"
echo " "

echo "[TASK $((++count))] installig linux headers"
sudo apt install -y linux-headers-`uname -r` >/dev/null 2>&1

echo "[TASK $((++count))] installing nvidia tesla"
cd /tmp/
wget https://us.download.nvidia.com/tesla/470.57.02/NVIDIA-Linux-x86_64-470.57.02.run >/dev/null 2>&1
sudo /bin/bash NVIDIA-Linux-x86_64-470.57.02.run --ui=none --no-questions --silent -X >/dev/null 2>&1

echo "[TASK $((++count))] installing hashcat"
cd /tmp/
wget https://hashcat.net/files/hashcat-6.2.4.7z >/dev/null 2>&1
7za x hashcat-6.2.4.7z >/dev/null 2>&1
mv hashcat-6.2.4 /home/admin/
ln -s /home/admin/hashcat-6.2.4/hashcat.bin /usr/local/bin/hashcat

echo " "
echo "done! please verify the drivers are working: \"sudo nvidia-smi\""
echo " "
