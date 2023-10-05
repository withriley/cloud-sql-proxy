module "proxy" {
  source               = "git::https://github.com/withriley/cloud-sql-proxy.git"
  project              = "gcp-project"
  region               = "australia-southeast1"
  db_name              = "mysql-instance"
  network              = "vpc-network"
  subnetwork           = "vpc-subnet"
  create_firewall_rule = true
  additional_ports     = ["3306"]
  members              = ["user:peter.griffin@withriley.com"]
}