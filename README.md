# alu-system_engineering-devops

SSH project: connecting to a server with a private key, creating an RSA key pair,
configuring the SSH client, and authorizing a public key on the server.

## ssh
- `0-use_a_private_key`: connects to the server as ubuntu using ~/.ssh/school
- `1-create_ssh_key_pair`: creates a 4096-bit RSA key pair named school (passphrase: betty)
- `2-ssh_config`: SSH client config that uses ~/.ssh/school and refuses password login
