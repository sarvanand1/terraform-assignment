resource "aws_key_pair" "newkey" {
  key_name   = "ssh-key"
  public_key = "${file("/home/sarva/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "ec2-instance" {
  count = length(var.subnet_id_for_ec2)

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_id_for_ec2, count.index)
  security_groups             = [var.vpc_security_group_id_for_ec2]
  associate_public_ip_address = true
  key_name                    = "ssh-key"

  tags = {
    Name = "${var.name}-${count.index}"
  }
}
