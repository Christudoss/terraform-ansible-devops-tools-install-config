data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "artifactory" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = "Irwin-01"
  network_interface {
    network_interface_id = aws_network_interface.devops.id
    device_index         = 0
  }

  tags = {
    Name = "devops"
  }


 ############################################################################
  # This is the 'remote exec' method.  
  # Ansible runs on the target host.
 #############################################################################

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/${var.ssh_user}/files",
      "mkdir /home/${var.ssh_user}/ansible",
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.artifactory.public_ip
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }
  }
  provisioner "file" {
    source      = "../ansible/"
    destination = "/home/${var.ssh_user}/ansible"

    connection {
      type        = "ssh"
      host        = aws_instance.artifactory.public_ip
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }
  }
  # provisioner "file" {
  #   source      = "../files/index.j2"
  #   destination = "/home/${var.ssh_user}/files/index.j2"

  #   connection {
  #     type        = "ssh"
  #     user        = "${var.ssh_user}"
  #     private_key = "${file("${var.private_key_path}")}"
  #   }
  # }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt update",
      "sudo apt -y install ansible",
      "sudo ansible-galaxy collection install jfrog.installers", 
    #  "cd ansible; ansible-playbook -c local -i \"localhost,\" playbook.yml",
      "cd ansible; ansible-playbook -c local -i "inventory.yml," playbook.yml",
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.artifactory.public_ip
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }
  }
#  Don't comment out this next line.
}