#!/bin/bash

input_file="$1"
output_file="$2"
ecc_private_key="ecc_private_key.pem"
shared_secret="shared_secret.bin"

echo "Performing ECC decryption for file: $input_file"

# Check if ECC private key file exists
if [[ ! -f "$ecc_private_key" ]]; then
    echo "Error: ECC private key file not found."
    exit 1
fi

# Generate the shared secret using ECC key exchange
openssl pkeyutl -derive -inkey "$ecc_private_key" -peerkey ecc_public_key.pem -out "$shared_secret"

# Decrypt the data using the shared secret with AES and PBKDF2 key derivation
openssl enc -d -aes-256-cbc -salt -pbkdf2 -a -in "$input_file" -pass file:"$shared_secret" -out "$output_file"

echo "File decrypted successfully and saved as: $output_file"

