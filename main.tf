resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-security-grp"
  description = "jenkins-sgs"


  ingress = [
   
   for port in [22 , 80 , 8080 ,443 ] : {

      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }            

  ]

   
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-sg"
  }

}

resource "aws_instance" "Ansible-jenkins" {
  ami           = "ami-0287a05f0ef0e9d9a"
  instance_type = "t2.micro"
  key_name = "k8s"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data = templatefile("./jenkins_install.sh",{})

  tags = {
    name: "jenkins-Ansible"
  }

  root_block_device {
    volume_size = 8
  }


}





  