#!/bin/bash

input_file="$1"
output_file="$2"
rsa_private_key="rsa_private_key.pem"
rsa_public_key="rsa_public_key.pem"

echo "Performing RSA encryption for file: $input_file"

# Check if RSA private key file exists, if not, generate it
if [[ ! -f "$rsa_private_key" ]]; then
    echo "Generating RSA private key..."
    openssl genpkey -algorithm RSA -out "$rsa_private_key"
    echo "RSA private key generated and saved as: $rsa_private_key"
fi

# Check if RSA public key file exists, if not, extract it from private key
if [[ ! -f "$rsa_public_key" ]]; then
    echo "Extracting RSA public key from private key..."
    openssl rsa -pubout -in "$rsa_private_key" -out "$rsa_public_key"
    echo "RSA public key extracted and saved as: $rsa_public_key"
fi

# Perform RSA encryption with the generated keys
openssl pkeyutl -encrypt -pubin -inkey "$rsa_public_key" -in "$input_file" -out "$output_file"

echo "File encrypted successfully and saved as: $output_file"





