# VPN Gateway with Route Table and Route Proprgation

resource "aws_vpn_gateway" "my_vpn_gateway" {
  vpc_id = "${aws_vpc.my_vpc.id}"
}


resource "aws_vpn_gateway_attachment" "my_vpn_attachment" {
  vpc_id         = "${aws_vpc.my_vpc.id}"
  vpn_gateway_id = "${aws_vpn_gateway.my_vpn_gateway.id}"
}


resource "aws_route_table" "my_route_table" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_vpn_gateway.my_vpn_gateway.id}"
    }

    tags {
        Name = "RT-1"
    }
}


resource "aws_route_table_association" "my_rt_association" {
    subnet_id = "${aws_subnet.my_subnet.id}"
    route_table_id = "${aws_route_table.my_routeble.id}"
}


resource "aws_vpn_gateway_route_propagation" "example" {
  vpn_gateway_id = "${aws_vpn_gateway.my_vpn_gateway.id}"
  route_table_id = "${aws_route_table.my_route_table.id}"
}


resource "aws_customer_gateway" "my_customer_gateway" {
  bgp_asn    = 64601
  ip_address = "1.1.1.1"
  type       = "ipsec.1"
}


resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.my_vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.my_customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = false
}



