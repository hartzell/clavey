# Configure the AWS Provider
provider "aws" {
    #access_key = ""
    #secret_key = ""
    region = "us-west-2"
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
    description = "Allow ssh connections on port 22"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a web server
resource "aws_instance" "hub" {
	# ami = "ami-53fcb763"
	ami = "ami-dd1419ed"
    	instance_type = "t2.micro"
	key_name = "my-first-key-pair"
	#security_groups = ["${aws_security_group.allow_ssh.id}"]
	vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
	root_block_device = {
    		delete_on_termination = 1
  	}
    	tags {
        	Name = "HelloWorld"
    	}
}
