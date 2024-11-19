#!/bin/bash

input_file="$1"
output_file="$2"
rsa_private_key="rsa_private_key.pem"

echo "Performing RSA decryption for file: $input_file"

# Check if RSA private key file exists
if [[ ! -f "$rsa_private_key" ]]; then
    echo "Error: RSA private key file not found. Please generate the private key first."
    exit 1
fi

# Perform RSA decryption with the private key
openssl pkeyutl -decrypt -inkey "$rsa_private_key" -in "$input_file" -out "$output_file"

echo "File decrypted successfully and saved as: $output_file"





