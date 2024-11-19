#!/bin/bash

input_file="$1"
output_file="$2"
ecc_public_key="ecc_public_key.pem"
shared_secret="shared_secret.bin"

echo "Performing ECC encryption for file: $input_file"

# Check if ECC public key file exists
if [[ ! -f "$ecc_public_key" ]]; then
    echo "Error: ECC public key file not found."
    exit 1
fi

# Generate a shared secret using ECC key exchange
openssl pkeyutl -derive -inkey ecc_private_key.pem -peerkey "$ecc_public_key" -out "$shared_secret"

# Encrypt the data using the shared secret with AES and PBKDF2 key derivation
encrypted_data=$(openssl enc -aes-256-cbc -salt -pbkdf2 -a -in "$input_file" -pass file:"$shared_secret")

# Store the encrypted data in the specified output file
echo "$encrypted_data" > "$output_file"

echo "File encrypted successfully and saved as: $output_file"

