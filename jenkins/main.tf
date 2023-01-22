provider "aws" {
    region = var.region
  
}
data "aws_ami" "amazon_linux_latest" {

    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]

    }
}

resource "aws_security_group" "jenkinsserver" {
    name = "Sec group for Jenkins"

    dynamic "ingress" {
        for_each = var.secgr_ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = var.cidr
        }
    }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = var.cidr
    
  }

    tags = {
        name = "Jenkins secGroup"
        owner = "Andriy Andrukhiv"
    }

}

resource "tls_private_key" "oskey" {
  algorithm = "RSA"
}

resource "local_file" "myterrakey" {
  content  = tls_private_key.oskey.private_key_pem
  filename = "myterrakey.pem"
}

resource "aws_key_pair" "key121" {
  key_name   = "myterrakey"
  public_key = tls_private_key.oskey.public_key_openssh
}

resource "aws_instance" "jenkins_server" {
  ami           = data.aws_ami.amazon_linux_latest.id
  vpc_security_group_ids = [aws_security_group.jenkinsserver.id]
  instance_type = var.instance_type
  key_name = aws_key_pair.key121.key_name

 connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "ec2-user"
    private_key = tls_private_key.oskey.private_key_pem
  }

provisioner "file" {
        source      = "files/Dockerfile"
        destination = "/tmp/Dockerfile"
    }

provisioner "file" {
        source      = "files/jenkins-plugins"
        destination = "/tmp/jenkins-plugins"
    }


provisioner "file" {
        source      = "files/default-user.groovy"
        destination = "/tmp/default-user.groovy"
    }


provisioner "remote-exec" {
        inline = [

            # steps to setup docker ce
            "sudo yum update -y",
            "sudo yum install nginx -y",
            "sudo amazon-linux-extras install docker -y",
            "sudo service docker start",
            "cd /tmp",
            "cd /tmp && sudo docker build -t jenkins:jcasc .",
            "sudo docker run -d --name jenkins -p 8080:8080 jenkins:jcasc",
            
        ]

              }
}

    


