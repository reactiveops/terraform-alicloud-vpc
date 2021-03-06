#Copyright 2017 FairwindsOps Inc.
#
#Licensed under the Apache License, Version 2.0 (the “License”);
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an “AS IS” BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

resource "alicloud_security_group" "vpc-sg" {
  name = "${var.vpc_security_group_name}"
  vpc_id = "${alicloud_vpc.default.id}"
  description = "Security group for VPC instances"
}

resource "alicloud_security_group_rule" "ssh-in" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "22/22"
  priority = 1
  security_group_id = "${alicloud_security_group.vpc-sg.id}"
  cidr_ip = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "http-in" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "80/80"
  priority = 2
  security_group_id = "${alicloud_security_group.vpc-sg.id}"
  cidr_ip = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "https-in" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "443/443"
  priority = 3
  security_group_id = "${alicloud_security_group.vpc-sg.id}"
  cidr_ip = "0.0.0.0/0"
}

output "sg_id" {
  value = "${alicloud_security_group.vpc-sg.id}"
}
