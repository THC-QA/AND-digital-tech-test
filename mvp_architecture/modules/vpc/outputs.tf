output "vpc_id" {
    value = aws_vpc.test_vpc.id
}
output "pub_sub_1_id" {
    value = aws_subnet.public_block_1.id
}
output "pub_sub_2_id" {
    value = aws_subnet.public_block_2.id
}