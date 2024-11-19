#!/bin/bash

input_file="$1"
output_file="$2"
camellia_key="camellia_key.txt"

echo "Performing Camellia decryption for file: $input_file"

# Check if Camellia key file exists
if [[ ! -f "$camellia_key" ]]; then
    echo "Error: Camellia encryption key file not found. Please generate the key first."
    exit 1
fi

# Read encryption algorithm information from the encrypted file
encryption_algorithm=$(head -n 1 "$input_file.txt")

# Check if decryption algorithm matches the encryption algorithm
if [[ $encryption_algorithm != "CAMELLIA" ]]; then
    echo "Warning: The file was encrypted using $encryption_algorithm algorithm."
    echo "Please use the $encryption_algorithm algorithm for decryption."
    echo "Decryption aborted."
    exit 1
fi

# Perform Camellia decryption with the key using PBKDF2
openssl enc -d -camellia-256-cbc -in "$input_file" -out "$output_file" -pass file:"$camellia_key" -pbkdf2

echo "File decrypted successfully and saved as: $output_file"