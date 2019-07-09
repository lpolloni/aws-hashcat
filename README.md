# AWS & HashCat

A AWS &amp; Hashcat environment for WPA2 Brute force attack

## Introduction

One big question when it comes to breaking passwords by brute force is: How long will it take?

While the password  **112233** would only take 1 second to be discovered through trial and error, consisting of several combinations, a password like **fDb#E!*##12c** would take 4 centuries, according to [Kaspersky Calculator](https://password.kaspersky.com/?/utm_medium=rdr&utm_source=redirector&utm_campaign=old_url). The problem is that it is not enough to have a "Gamer" computer, it will not be enough if the password is a bit more complex, we often have even modest computers.

An alternative is to use **AWS** to accomplish this task, there are very powerful **EC2** instances in which we can enjoy paying for hours of use.

We can use instances of type P3 for example, which contains the following configuration:

Name | GPUs | GPU Mem | vCPU | Mem (GiB) | Cost/hour 
-----|------|---------|------|-----------|----------
p3.2xlarge | 1 | 12 | 4 | 61 | $ 3.06 
p3.8xlarge | 8 | 96 | 32 | 488 | $ 12.24
p3.16xlarge | 16 | 192 | 64 | 732 | $ 24.48

## Prerequisites

To perform this process you must have the following requirements:

* Knowledge of Linux
* Account with AWS
* Be willing to spend

## Configuration

With the pre requisites fulfilled hands down.

### Uploading Instance

1. Select the AMI Ubuntu Server 16.04 LTS (HVM), SDD Volume type
1. Choose the type, in this example I'll use '' p3.8xlarge ''
1. Configure the details, storage, security group, key pair, etc.
1. After creating the instance make the connection via SSH

At this point we will do the initial configuration.

### Configuration

Update apt

```
sudo apt-get update -yq
```

Install the packages

```
sudo apt-get install -yq build-essential linux-headers - $ (uname -r) unzip p7zip-full linux-image-extra-virtual python3-pip
```

And the pack '' psutill '' with '' pip ''

```
pip3 install psutil
```

Create the file '' blacklist-nouveau.conf ''

```
sudo touch /etc/modprobe.d/blacklist-nouveau.conf
```

Enter the following lines

```
nouveau blacklist
blacklist lbm-nouveau
options nouveau modeset = 0
alias nouveau off
alias lbm-nouveau off
```
Create the file '' nouveau-kms.conf ''

```
sudo touch /etc/modprobe.d/nouveau-kms.conf
```
Enter the following line
Enter the following line

```
options nouveau modeset = 0


And then upgrade

<file bash>
sudo update-initramfs -u
</ file>

Download NVIDIA

<file bash>
cd / tmp
wget http://us.download.nvidia.com/tesla/410.104/NVIDIA-Linux-x86_64-410.104.run
</ file>

Do the installation

<file bash>
sudo / bin / bash NVIDIA-Linux-x86_64-410.104.run --ui = none --no-questions --silent -X
</ file>

Download HashCat

<file bash>
git clone https://github.com/hashcat/hashcat.git
</ file>

And then do the installation

<file bash>
sudo make
sudo make install
</ file>

At this point you can put your '.hccapx' files on the server, if you have captured the handshake through '' Aircrack-ng '' you can convert the file '' .cap '' to '' .hccapx '' without much trouble, a very simple alternative is to use a tool called [[https://hashcat.net/cap2hccap/|cap2hccap]] from HashCat itself.

Now just launch the command and wait for the password to be discovered, for more information on usage consult HashCat [[https://hashcat.net/wiki/|Documentation]].

