output "efs_mount_dns" {
  value = "${aws_efs_mount_target.alpha.0.dns_name}"
}
output "Frontend_Instance_IP" {
  value = "${aws_instance.frontend-instance.public_ip}"
}
output "Frontend_Instance_DNS" {
  value = "${aws_instance.frontend-instance.public_dns}"
}
