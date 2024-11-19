#!/bin/bash

input_file="$1"
output_file="$2"
camellia_key="camellia_key.txt"
encryption_algorithm="CAMELLIA"

if [[ -z "$input_file" || -z "$output_file" ]]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file '$input_file' not found!"
    exit 1
fi

echo "Performing Camellia encryption for file: $input_file"

# Check if Camellia key file exists, if not, generate it
if [[ ! -f "$camellia_key" ]]; then
    echo "Generating Camellia encryption key..."
    openssl rand -base64 32 > "$camellia_key"
    echo "Camellia encryption key generated and saved as: $camellia_key"
fi

# Store the encryption algorithm in the encrypted file
echo "$encryption_algorithm" > "$output_file.txt"

# Perform Camellia encryption with the generated key using PBKDF2
openssl enc -camellia-256-cbc -salt -in "$input_file" -out "$output_file" -pass file:"$camellia_key" -pbkdf2
echo "File encrypted successfully and saved as: $output_file"



