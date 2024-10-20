resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.projeto}-${var.candidato}-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

data "aws_ami" "debian12" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "debian_ec2" {
  ami             = data.aws_ami.debian12.id
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
  key_name        = aws_key_pair.ec2_key_pair.key_name

  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  # Configuração de inicialização da instância (User Data)
  user_data = <<-EOF
              #!/bin/bash
              # Atualizar pacotes
              apt-get update -y
              
              # Instalar Nginx
              apt-get install -y nginx
              
              # Iniciar o serviço Nginx
              systemctl start nginx
              
              # Habilitar Nginx para iniciar automaticamente ao boot
              systemctl enable nginx
              EOF


  tags = {
    Name = "${var.projeto}-${var.candidato}-ec2"
  }
}



