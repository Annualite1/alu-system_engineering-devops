#!/usr/bin/env bash
set -e

REPO="alu-system_engineering-devops"
DIR="ssh"
SERVER_IP="${SERVER_IP:-YOUR_SERVER_IP}"
REMOTE_URL="${REMOTE_URL:-}"
GIT_NAME="${GIT_NAME:-student}"
GIT_EMAIL="${GIT_EMAIL:-student@example.com}"

PUBKEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNdtrNGtTXe5Tp1EJQop8mOSAuRGLjJ6DW4PqX4wId/Kawz35ESampIqHSOTJmbQ8UlxdJuk0gAXKk3Ncle4safGYqM/VeDK3LN5iAJxf4kcaxNtS3eVxWBE5iF3FbIjOqwxw5Lf5sRa5yXxA8HfWidhbIG5TqKL922hPgsCGABIrXRlfZYeC0FEuPWdr6smOElSVvIXthRWp9cr685KdCI+COxlj1RdVsvIo+zunmLACF9PYdjB2s96Fn0ocD3c5SGLvDOFCyvDojSAOyE70ebIElnskKsDTGwfT4P6jh9OBzTyQEIS2jOaE5RQq4IB4DsMhvbjDSQrP0MdCLgwkN'

# 1. Create the repo and enter it
mkdir -p "/$REPO"
cd "/$REPO"
git init -q

# 2. Create the directory and enter it
mkdir -p "$DIR"
cd "$DIR"

# 3. Create the files
cat > 0-use_a_private_key <<EOF
#!/usr/bin/env bash
# Connects to the server as ubuntu using the private key ~/.ssh/school
ssh -i ~/.ssh/school ubuntu@${SERVER_IP}
EOF

cat > 1-create_ssh_key_pair <<'EOF'
#!/usr/bin/env bash
# Creates a 4096-bit RSA key pair named school, passphrase: betty
ssh-keygen -t rsa -b 4096 -f school -N betty
EOF

cat > 2-ssh_config <<'EOF'
# SSH client configuration
Host *
    IdentityFile ~/.ssh/school
    PasswordAuthentication no
EOF

chmod +x 0-use_a_private_key 1-create_ssh_key_pair

# Run task 1 and install the key where tasks 0 and 2 expect it
mkdir -p ~/.ssh && chmod 700 ~/.ssh
if [ ! -f ~/.ssh/school ]; then
    ./1-create_ssh_key_pair
    cp school school.pub ~/.ssh/
    chmod 600 ~/.ssh/school
fi

# Merge the client config into ~/.ssh/config (once)
touch ~/.ssh/config
grep -q "IdentityFile ~/.ssh/school" ~/.ssh/config || {
    echo >> ~/.ssh/config
    cat 2-ssh_config >> ~/.ssh/config
}
chmod 600 ~/.ssh/config

# Task 3: add the given public key (this terminal is the server itself)
touch ~/.ssh/authorized_keys
grep -qF "$PUBKEY" ~/.ssh/authorized_keys || echo "$PUBKEY" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Add, commit and push (only the three task files, never the private key)
cd "/$REPO"
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"
git add "$DIR/0-use_a_private_key" "$DIR/1-create_ssh_key_pair" "$DIR/2-ssh_config"
git commit -m "Add SSH project: private key use, key pair creation, client config" || echo "Nothing new to commit."
git branch -M main

if [ -n "$REMOTE_URL" ]; then
    git remote remove origin 2>/dev/null || true
    git remote add origin "$REMOTE_URL"
    git push -u origin main
else
    echo "Push skipped: set REMOTE_URL to push."
fi

echo "Done."
ls -l "/$REPO/$DIR"
