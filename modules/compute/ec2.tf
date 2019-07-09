resource "aws_instance" "resource_ec2" {
  count = "${var.create ? length(var.auto_ec2_rules[var.ec2_env]) : 0}"

  ami                          = "${var.ami_id}"
  instance_type                = "${element(var.ec2_rules[element(var.auto_ec2_rules[var.ec2_env], count.index)], 1)}"
  associate_public_ip_address  = "${element(var.ec2_rules[element(var.auto_ec2_rules[var.ec2_env], count.index)], 2)}"
  availability_zone            = "${var.ec2_av}"
  subnet_id                    = "${var.subnet_id}"
  vpc_security_group_ids       = ["${element(var.sg_ids, count.index)}"]
  key_name                     = "kp-${var.ec2_env}" 

  root_block_device {
    volume_size = "${element(var.ec2_rules[element(var.auto_ec2_rules[var.ec2_env], count.index)], 3)}"
  }

  tags {
    Name  = "ec2-${var.ec2_env}-${element(var.auto_ec2_rules[var.ec2_env], count.index)}"
  }

  connection {
    user        = "admin"
    private_key = "${file("kp-${var.ec2_env}.pem")}"
    timeout     = "1m"
  }
  provisioner "file" {
    source      = "${element(var.auto_ec2_rules[var.ec2_env], count.index)}_default.sh"
    destination = "/tmp/${element(var.auto_ec2_rules[var.ec2_env], count.index)}_default.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/${element(var.auto_ec2_rules[var.ec2_env], count.index)}_default.sh",
      "sudo /tmp/${element(var.auto_ec2_rules[var.ec2_env], count.index)}_default.sh",      
    ]
  }
}