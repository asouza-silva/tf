
output "ec2_public_ip" {
  description = "Public IP EC2"
  value       = aws_instance.debian_ec2.public_ip
}

# Output para chave privada SSH
output "tls_private_key" {
  description = "Private key to SSH"
  value       = tls_private_key.ec2_key.private_key_pem
  sensitive   = true
}
