# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "vpcmasterkey"
  public_key = "${file("${var.key_path}")}"
}

# create file storage
resource "aws_efs_file_system" "default-store" {
  tags {
    Name = "${var.client}.${var.project} EFS Filesystem"
    Client = "${var.client}"
    Project = "${var.project}"
    CostCenter = "${var.costcenter}"
    Environment = "${var.environment}"
  }
}

resource "aws_efs_mount_target" "alpha" {
  file_system_id = "${aws_efs_file_system.default-store.id}"
  subnet_id      = "${aws_subnet.public-subnet.id}"
  security_groups = ["${aws_security_group.frontendsg.id}"]

}

# Define webserver inside the public subnet
resource "aws_instance" "frontend-instance" {
   ami  = "${var.ami}"
   instance_type = "t2.nano"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.frontendsg.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("scripts/install.sh")}"

  tags {
    Name = "${var.client}.${var.project} webserver"
    Client = "${var.client}"
    Project = "${var.project}"
    CostCenter = "${var.costcenter}"
    Environment = "${var.environment}"
  }
}
