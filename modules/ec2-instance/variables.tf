variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "example-ec2"
}