#!/bin/bash

# Function to generate AES key
generate_aes_key() {
    if [[ -f "aes_key.txt" ]]; then
        read -p "$(tput setaf 11)AES key already exists. Do you want to overwrite it? (y/n): $(tput sgr0)" overwrite
        if [[ $overwrite == "y" || $overwrite == "Y" ]]; then
            echo "$(tput setaf 10)Generating AES encryption key...$(tput sgr0)"
            openssl rand -base64 32 > aes_key.txt
            echo "$(tput setaf 10)AES encryption key generated and saved as: aes_key.txt$(tput sgr0)"
        else
            echo "$(tput setaf 11)AES key generation skipped.$(tput sgr0)"
        fi
    else
        echo "$(tput setaf 10)Generating AES encryption key...$(tput sgr0)"
        openssl rand -base64 32 > aes_key.txt
        echo "$(tput setaf 10)AES encryption key generated and saved as: aes_key.txt$(tput sgr0)"
    fi
}

# Function to generate Camellia key
generate_camellia_key() {
    if [[ -f "camellia_key.txt" ]]; then
        read -p "$(tput setaf 11)Camellia key already exists. Do you want to overwrite it? (y/n): $(tput sgr0)" overwrite
        if [[ $overwrite == "y" || $overwrite == "Y" ]]; then
            echo "$(tput setaf 10)Generating Camellia encryption key...$(tput sgr0)"
            openssl rand -base64 32 > camellia_key.txt
            echo "$(tput setaf 10)Camellia encryption key generated and saved as: camellia_key.txt$(tput sgr0)"
        else
            echo "$(tput setaf 11)Camellia key generation skipped.$(tput sgr0)"
        fi
  else
        echo "$(tput setaf 10)Generating Camellia encryption key...$(tput sgr0)"
        openssl rand -base64 32 > camellia_key.txt
        echo "$(tput setaf 10)Camellia encryption key generated and saved as: camellia_key.txt$(tput sgr0)"
    fi
}
# Function to generate RSA key pair
generate_rsa_keys() {
    if [[ -f "rsa_private_key.pem" && -f "rsa_public_key.pem" ]]; then
        read -p "$(tput setaf 11)RSA key pair already exists. Do you want to overwrite it? (y/n): $(tput sgr0)" overwrite
        if [[ $overwrite == "y" || $overwrite == "Y" ]]; then
            echo "$(tput setaf 10)Generating RSA key pair...$(tput sgr0)"
            openssl genpkey -algorithm RSA -out rsa_private_key.pem
            openssl rsa -pubout -in rsa_private_key.pem -out rsa_public_key.pem
            echo "$(tput setaf 10)RSA key pair generated:$(tput sgr0)"
            echo "$(tput setaf 10)Private key saved as: rsa_private_key.pem$(tput sgr0)"
            echo "$(tput setaf 10)Public key saved as: rsa_public_key.pem$(tput sgr0)"
        else
            echo "$(tput setaf 11)RSA key pair generation skipped.$(tput sgr0)"
        fi
    else
        echo "$(tput setaf 10)Generating RSA key pair...$(tput sgr0)"
        openssl genpkey -algorithm RSA -out rsa_private_key.pem
        openssl rsa -pubout -in rsa_private_key.pem -out rsa_public_key.pem
        echo "$(tput setaf 10)RSA key pair generated:$(tput sgr0)"
        echo "$(tput setaf 10)Private key saved as: rsa_private_key.pem$(tput sgr0)"
        echo "$(tput setaf 10)Public key saved as: rsa_public_key.pem$(tput sgr0)"
    fi
}
# Function to generate ECC key pair
generate_ecc_keys() {
    if [[ -f "ecc_private_key.pem" && -f "ecc_public_key.pem" ]]; then
        read -p "$(tput setaf 11)ECC key pair already exists. Do you want to overwrite it? (y/n): $(tput sgr0)" overwrite
        if [[ $overwrite == "y" || $overwrite == "Y" ]]; then
            echo "$(tput setaf 10)Generating ECC key pair...$(tput sgr0)"
            openssl ecparam -name secp256k1 -genkey -noout -out ecc_private_key.pem
            openssl ec -in ecc_private_key.pem -pubout -out ecc_public_key.pem
            echo "$(tput setaf 10)ECC key pair generated:$(tput sgr0)"
            echo "$(tput setaf 10)Private key saved as: ecc_private_key.pem$(tput sgr0)"
            echo "$(tput setaf 10)Public key saved as: ecc_public_key.pem$(tput sgr0)"
        else
            echo "$(tput setaf 11)ECC key pair generation skipped.$(tput sgr0)"
        fi
    else
        echo "$(tput setaf 10)Generating ECC key pair...$(tput sgr0)"
        openssl ecparam -name secp256k1 -genkey -noout -out ecc_private_key.pem
        openssl ec -in ecc_private_key.pem -pubout -out ecc_public_key.pem
        echo "$(tput setaf 10)ECC key pair generated:$(tput sgr0)"
        echo "$(tput setaf 10)Private key saved as: ecc_private_key.pem$(tput sgr0)"
        echo "$(tput setaf 10)Public key saved as: ecc_public_key.pem$(tput sgr0)"
    fi
}

# Main script
echo "$(tput bold)Key Generation Script$(tput sgr0)"
echo "$(tput bold)Choose the encryption algorithm for which you want to generate a key:$(tput sgr0)"
echo "$(tput setaf 14)1. AES$(tput sgr0)"
echo "$(tput setaf 14)2. Camellia$(tput sgr0)"
echo "$(tput setaf 14)3. RSA$(tput sgr0)"
echo "$(tput setaf 14)4. ECC$(tput sgr0)"
echo "$(tput setaf 14)5. All$(tput sgr0)"
read -p "$(tput bold)Enter your choice: $(tput sgr0)" choice

case $choice in
    1) generate_aes_key;;
    2) generate_camellia_key;;
    3) generate_rsa_keys;;
    4) generate_ecc_keys;;
    5) generate_aes_key
       generate_camellia_key
       generate_rsa_keys
       generate_ecc_keys;;
    *) echo "$(tput setaf 9)Invalid choice. Please enter a number between 1 and 5.$(tput sgr0)" ;;
esac
