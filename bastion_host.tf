resource "aws_instance" "Bastion_Host" {
  ami           = "ami-068257025f72f470d"
  instance_type = "t2.micro"

  #VPC
  vpc_security_group_ids = [aws_security_group.bastion_host_server_sg.id] #VPC
  #Keypair
  key_name = "bastion_host_key"
  #Subnet_id
  subnet_id = data.aws_subnet.public_a.id

  tags = {
    Name = "Bastion_host_subnet"
  }

}