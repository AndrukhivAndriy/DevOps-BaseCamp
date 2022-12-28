
#--------------------------------------
# Availability zones
#--------------------------------------
data "aws_availability_zones" "all" {}
#--------------------------------------
# Find latest Amazon Linux on EC2
#--------------------------------------
data "aws_ami" "amazon_linux_latest" {

    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]

    }
}
#-----------------------------
# Create Dynamic Security Group
#-----------------------------
resource "aws_security_group" "grafana_server" {
    name = "Sec group for Grafana"

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
        name = "Grafana secGroup"
        owner = "Andriy Andrukhiv"
    }

}
#-------------------------------------
#  Create Launch Configuration
#-------------------------------------
resource "aws_launch_configuration" "Grafanalc" {
  name          = "Grafana-server-lc"
  image_id      = data.aws_ami.amazon_linux_latest.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.grafana_server.id]
  associate_public_ip_address = true
  user_data = file("userdata/awsuserdata.sh")
  key_name = file("userdata/onekey.pub")

  lifecycle {
    create_before_destroy = true
  }
}

#-----------------------------------------------
# Create Autoscaling Group
# ----------------------------------------------
resource "aws_autoscaling_group" "Grafana" {
  name                      = "Asgroup-for-Grafana"
  launch_configuration      = aws_launch_configuration.Grafanalc.id
  max_size                  = 2
  min_size                  = 2
  health_check_type         = "ELB"
  availability_zones        = data.aws_availability_zones.all.names
  load_balancers            = [aws_elb.Grafana-Load-Balancer.name]

  dynamic "tag" {
    for_each  = {
        name  = "Grafana-in-ASG"
        owner = "Andriy Andrukhiv"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true

    }
    
  }
  lifecycle {
    create_before_destroy = true
  }
  
}

#------------------------------------------
# Create Load Balancer
#------------------------------------------

resource "aws_elb" "Grafana-Load-Balancer" {
    name = "Grafana-elb"
    availability_zones   = data.aws_availability_zones.all.names
    security_groups = [aws_security_group.grafana_server.id]
    listener {
        lb_port           = 80
        lb_protocol       = "http"
        instance_port     = 3000
        instance_protocol = "http"
    }
    cross_zone_load_balancing   = true
    health_check {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 3
      target              = "TCP:3000"
      interval            = 5

    }
    tags = {
      "name" = "Load-Bal-for-Grafana"
    }
}

#------------------------------------------
# AZ definition. 2 zones
#------------------------------------------

#data "aws_availability_zones" "available" {
#  state = "available"
#}

#resource "aws_default_subnet" "default_az1" {
#    availability_zone = data.aws_availability_zones.available.names[0]
#}

#resource "aws_default_subnet" "default_az2" {
#   availability_zone = data.aws_availability_zones.available.names[1]
#}

