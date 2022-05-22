
data "aws_ami" "my_custom_aws_ami" {
    owners = var.owners
  filter {
    name   = var.filter_tags.name_tag
    values = var.filter_tags.name_values
  }

  filter {
    name   = var.filter_tags.id_tag
    values = var.filter_tags.id_values
  }
}

resource "aws_security_group" "my_security_grp" {
  ingress {
     cidr_blocks      = [ "0.0.0.0/0", ]
     from_port        = 22
     ipv6_cidr_blocks = ["::/0"]
     protocol         = "tcp"
     to_port          = 22
   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 
  
}

resource "aws_instance" "ec2_test_3" {
    ami = data.aws_ami.my_custom_aws_ami.id
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.my_security_grp.id]
    iam_instance_profile = var.iam_instance_profile
    tags = {
    Name = var.instance_name
    }

    connection {
    type     = var.connection_type
    user     = var.connection_user
    private_key = var.private_key_pem
    host     = self.public_ip
  }

    provisioner "file" {
    source      = "${path.module}/config/md5_script_ec2.bash"
    destination = "${var.root_path}/md5_script_ec2.bash"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh -x ${var.root_path}/md5_script_ec2.bash ${var.bucket_name}"  ,
      "exit"
    ]
  }
  
}

