# AWS & HashCat

A AWS &amp; Hashcat environment for WPA2 Brute force attack


====== AWS & HashCat ======

===== Introdução =====

Uma grande questão quando se trata de quebrar senhas por força bruta é: Quanto tempo levará? 

Enquanto a senha ''112233'' levaria apenas 1 segundo para ser descoberta através de tentativa e erro, formado por várias combinações, uma senha como ''fDb#E!*##12c'' levaria 4 séculos, segundo a [[https://password.kaspersky.com/br/?utm_medium=rdr&utm_source=redirector&utm_campaign=old_url|Calculadora da Kaspersky]]. O problema é que não basta tem um computador "Gamer", ele não será o suficiente se a senha for um pouco mais complexa, muitas vezes temos computadores até mais modestos.

Uma alternativa é usar a **AWS** para realizar essa tarefa, existem instâncias **EC2** muito potentes, no qual podemos usufruir pagando pelas horas de uso.

Podemos usar as instâncias do tipo P3 por exemplo, que contém a seguinte configuração:

^ Nome        ^ GPUs ^ GPU Mem ^ vCPU ^ Mem(GiB) ^ Custo/hora ^
| p3.2xlarge  | 1    | 12      | 4   | 61        | $3.06   |
| p3.8xlarge  | 8    | 96      | 32  | 488       | $12.24  |
| p3.16xlarge |16    | 192     | 64  | 732       | $24.48  |

===== Pré requisitos =====

Para realizar esse processo será preciso ter os seguintes requisitos:

  * Conhecimento de Linux
  * Conta na AWS
  * Estar disposto a gastar $


===== Configuração =====

Com os pré requisitos preenchidos mãos à obra.

==== Subindo a Instância ====

  - Selecione a AMI Ubuntu Server 16.04 LTS (HVM), SDD Volume type
  - Escolha o tipo, neste exemplo usarei ''p3.8xlarge''
  - Configure os detalhes, storage, security group, key pair, etc.
  - Após criar a instância faça a conexão por SSH

Nesse momento faremos a configuração inicial.

==== Configuração ====

Atualize o apt

<file bash>
sudo apt-get update -yq
</file>

Instale os pacotes

<file bash>
sudo apt-get install -yq build-essential linux-headers-$(uname -r) unzip p7zip-full linux-image-extra-virtual python3-pip
</file>

E o pacote ''psutill'' com ''pip''

<file bash>
pip3 install psutil
</file>

Crie o arquivo ''blacklist-nouveau.conf''

<file bash>
sudo touch /etc/modprobe.d/blacklist-nouveau.conf
</file>

Insira as seguintes linhas

<file bash>
blacklist nouveau
blacklist lbm-nouveau
options nouveau modeset=0
alias nouveau off
alias lbm-nouveau off
</file>

Crie o arquivo ''nouveau-kms.conf''

<file bash>
sudo touch /etc/modprobe.d/nouveau-kms.conf
</file>

Insira a seguinte linha

<file bash>
options nouveau modeset=0
</file>

E então atualize

<file bash>
sudo update-initramfs -u
</file>

Faça o download do NVIDIA

<file bash>
cd /tmp
wget http://us.download.nvidia.com/tesla/410.104/NVIDIA-Linux-x86_64-410.104.run
</file>

Faça a instalação

<file bash>
sudo /bin/bash NVIDIA-Linux-x86_64-410.104.run --ui=none --no-questions --silent -X
</file>

Faça o download do HashCat

<file bash>
git clone https://github.com/hashcat/hashcat.git
</file>

E então faça a instalação

<file bash>
sudo make
sudo make install
</file>

Nesse momento você pode colocar os seus arquivos no formato ''.hccapx'' no servidor, caso você tenha capturado o handshake através do ''Aircrack-ng'' você pode converter o arquivo ''.cap'' para ''.hccapx'' sem muito problema, uma alternativa bem simples é usar uma ferramenta chamada [[https://hashcat.net/cap2hccap/|cap2hccap]] da própria HashCat.

Agora é só disparar o comando e esperar a descoberta do password, para mais informações sobre o uso consulte a [[https://hashcat.net/wiki/|Documentação]] da HashCat.

==== Script de configuração ====

Abaixo está o script completo, pronto pra você rodar.

<file bash conf.sh>
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
</file>
