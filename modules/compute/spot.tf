resource "aws_spot_instance_request" "resource-spot" {
  count = var.create ? length(var.ec2-type[var.environment]) : 0

  ami = "ami-089fe97bc00bff7cc"
  instance_type = element(var.ec2-type[var.environment], count.index)
  availability_zone = element(var.availability-zones[var.environment], count.index)
  subnet_id = element(var.subnet-id, count.index)
  key_name = "key-${var.name}-${var.environment}.pub"
  vpc_security_group_ids = element(var.sgroup-id, count.index)
  associate_public_ip_address = true
  ebs_optimized = false
  disable_api_termination = false
  hibernation = false
  monitoring = false
  wait_for_fulfillment = true

  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
    delete_on_termination = true
  }

  connection {
      host = self.public_ip
      type = "ssh"
      user = "admin"
      private_key = file("${var.name}-${var.environment}.pem")
      timeout = "2m"
  }

  provisioner "remote-exec" {
      inline = [
        "sudo hostname ec2-${var.name}-${var.environment}-${count.index}",
        "sudo bash -c \"echo '127.0.0.1 ec2-${var.name}-${var.environment}-${count.index}' >> /etc/hosts\" "
      ]
  }

  provisioner "file" {
    source = "./scripts/hashcat.sh"
    destination = "/home/admin/hashcat.sh"
  }

  provisioner "file" {
    source = "./scripts/initial-install.sh"
    destination = "/home/admin/initial-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/admin/{initial-install,hashcat}.sh",
      "/home/admin/initial-install.sh"
    ]
  }

  tags = {
      Name = "spot-${var.name}-${var.environment}-${count.index}"
  }
}
