# Create first webserver
resource "aws_instance" "webserver-1" {
    ami                 = "ami-0caef02b518350c8b"
    instance_type       = "t2.micro"
    availability_zone   = "eu-central-1a"
    security_groups     = ["${aws_security_group.webaccess.name}"] 
    user_data           = file("apache2.sh")
    key_name            = "crashcourse-key"
    tags = {
      Name = "webserver-1"
    }
}


# Create second webserver
resource "aws_instance" "webserver-2" {
    ami                 = "ami-0caef02b518350c8b"
    instance_type       = "t2.micro"
    availability_zone   = "eu-central-1b"
    security_groups     = ["${aws_security_group.webaccess.name}"] 
    user_data           = file("apache2.sh")
    key_name            = "crashcourse-key"
    tags = {
      Name = "webserver-2"
    }
}

# Create third webserver
resource "aws_instance" "webserver-3" {
    ami                 = "ami-0caef02b518350c8b"
    instance_type       = "t2.micro"
    availability_zone   = "eu-central-1c"
    security_groups     = ["${aws_security_group.webaccess.name}"] 
    user_data           = file("apache2.sh")
    key_name            = var.sshkey
    tags = {
      Name = "webserver-3"
    }
}


# Creating LB
resource "aws_elb" "endava-elb" {
    name = "endava-lb"
    availability_zones      = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    listener {
      instance_port       = 80
      instance_protocol   = "http"
      lb_port             = 80
      lb_protocol         = "http"
    }
    health_check {
      healthy_threshold      = 2
      unhealthy_threshold    = 2
      timeout               = 5
      target                = "HTTP:80/"
      interval              = 35
    }
    instances                    = ["${aws_instance.webserver-1.id}", "${aws_instance.webserver-2.id}", "${aws_instance.webserver-3.id}"]
    cross_zone_load_balancing    = true
    idle_timeout                 = 300
    connection_draining          = true
    connection_draining_timeout  = 300
    tags = {
      Name = "endava-load-balancer"
    }   
}

variable "ingress" {
    type = list(number)
    default = [22,80,443]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

resource "aws_security_group" "webaccess" {
    name = "Allow web Traffic"
    description = "SSH and HTTP"

    dynamic "ingress" {
        iterator = port
        for_each  = var.ingress
        content {
            from_port  = port.value
            to_port    = port.value
            protocol   = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
  
    dynamic "egress" {
        iterator = port
        for_each  = var.egress
        content {
            from_port  = port.value
            to_port    = port.value
            protocol   = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    tags = {
      Name = "LoadBalancer-SG"
    }
}



output "elb_dns_name" {
  description = "The ID and ARN of the load balancer we created."
  value = aws_elb.endava-elb.dns_name
}

