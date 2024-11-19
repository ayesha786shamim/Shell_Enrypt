#!/bin/bash

input_file="$1"
output_file="$2"
aes_key="aes_key.txt"

echo "Performing AES encryption for file: $input_file"

# Check if AES key file exists
if [[ ! -f "$aes_key" ]]; then
    echo "Error: AES encryption key file not found. Please generate the key first."
    exit 1
fi

# Perform AES encryption with the key using PBKDF2 for key derivation
openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -pass file:"$aes_key" -pbkdf2

echo "File encrypted successfully and saved as: $output_file"

