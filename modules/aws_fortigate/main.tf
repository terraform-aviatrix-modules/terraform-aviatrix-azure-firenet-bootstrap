data "template_file" "fortigate" {
  template = file("${path.module}/fortigate.tpl")

  vars = {
    hostname = var.hostname
    password = var.password
  }
}

