provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}


resource "yandex_vpc_network" "cloudpublic" {
  name = "cloudpublic"
}

resource "yandex_vpc_route_table" "rtpublic" {
  network_id = "${yandex_vpc_network.cloudpublic.id}"


  static_route {
    destination_prefix = "172.16.0.0/16"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.0.0/22"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.4.0/22"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.8.0/22"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.12.0/22"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.16.0/22"
    next_hop_address   = "10.128.0.5"
  }
  static_route {
    destination_prefix = "10.129.20.0/22"
    next_hop_address   = "10.128.0.5"
  }
}

resource "yandex_vpc_subnet" "public-a" {
  name           = "public-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.cloudpublic.id}"
  v4_cidr_blocks = ["10.128.0.0/24"]
  route_table_id = "${yandex_vpc_route_table.rtpublic.id}"
}

resource "yandex_vpc_subnet" "public-b" {
  name           = "public-b"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.cloudpublic.id}"
  v4_cidr_blocks = ["10.128.1.0/24"]
  route_table_id = "${yandex_vpc_route_table.rtpublic.id}"
}

resource "yandex_vpc_subnet" "public-c" {
  name           = "public-c"
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.cloudpublic.id}"
  v4_cidr_blocks = ["10.128.2.0/24"]
  route_table_id = "${yandex_vpc_route_table.rtpublic.id}"
}


output "public-a" {
  value = "${yandex_vpc_subnet.public-a}"
}

output "public-b" {
  value = "${yandex_vpc_subnet.public-b}"
}

output "public-c" {
  value = "${yandex_vpc_subnet.public-c}"
}

output "rtpublic" {
  value = "${yandex_vpc_route_table.rtpublic}"
}
