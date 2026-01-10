data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_name]
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  key_name               = var.key_name

  tags = {
    Name = var.instance_name
  }
}
