# --- compute/main.tf ---

data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "random_id" "vm_id" {
  byte_length = 2
  count       = var.instance_count
}


resource "aws_instance" "vm" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.amazon_linux.id

  tags = {
    Name = "vm-${random_id.vm_id[count.index].dec}"
  }

  key_name                    = var.key_name
  vpc_security_group_ids      = [var.public_sg]
  subnet_id                   = var.public_subnets[count.index]
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  root_block_device {
    volume_size = var.vol_size
  }
}
