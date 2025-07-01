provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  tags = {
    Name = "example-instance"
  }
}

resource "aws_autoscaling_group" "example" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 0
  vpc_zone_identifier  = ["subnet-12345678"]
  launch_configuration = aws_launch_configuration.example.id

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  security_groups = ["sg-12345678"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_instance" "example" {
  allocated_storage    = 20
  instance_class       = "db.t3.micro"
  engine               = "mysql"
  engine_version       = "5.7"
  name                 = "exampledb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
}
