# Internet Gate Way and Route Table

resource "aws_internet_gateway" "my_internet_gateway" {
    vpc_id = "${aws_vpc.my_vpc.id}"

    tags {
        Name = "main"
    }
}


resource "aws_route_table" "my_route_table" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.my_internet_gateway.id}"
    }

    tags {
        Name = "main"
    }
}


resource "aws_route_table_association" "my_route_table_association" {
    subnet_id = "${aws_subnet.my_subnet.id}"
    route_table_id = "${aws_route_table.my_route_table.id}"
}