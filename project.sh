#!/bin/bash

# Function to display the menu
display_menu() {
    echo "$(tput bold)==============================================$(tput sgr0)"
    echo "$(tput bold)🔐 Welcome to File Encryption and Decryption 🔓$(tput sgr0)"
    echo "$(tput bold)==============================================$(tput sgr0)"
    echo "$(tput setaf 14)1. Encrypt a file 📜$(tput sgr0)"
    echo "$(tput setaf 14)2. Decrypt a file 📂$(tput sgr0)"
    echo "$(tput setaf 14)3. Generate keys 🔑$(tput sgr0)"
    echo "$(tput setaf 14)4. Exit 🚪$(tput sgr0)"
    echo "$(tput bold)==============================================$(tput sgr0)"
}

# Function to handle encryption
encrypt_file() {
    echo "$(tput bold)🔒 Enter the path of the file to encrypt:$(tput sgr0)"
    read -r input_file

    if [[ ! -f "$input_file" ]]; then
        echo "$(tput setaf 1)Error: File not found!$(tput sgr0)"
        return 1
    fi

    echo "$(tput bold)📁 Enter the path where you want to save the encrypted file:$(tput sgr0)"
    read -r output_file

    echo "$(tput bold)Choose the encryption algorithm:$(tput sgr0)"
    echo "$(tput setaf 14)1. AES$(tput sgr0)"
    echo "$(tput setaf 14)2. RSA$(tput sgr0)"
    echo "$(tput setaf 14)3. Camellia$(tput sgr0)"
    echo "$(tput setaf 14)4. ECC$(tput sgr0)"
    read -r choice

    case $choice in
    1) ./encrypt_aes.sh "$input_file" "$output_file";;
    2) ./encrypt_rsa.sh "$input_file" "$output_file";;
    3) ./encrypt_camellia.sh "$input_file" "$output_file";;
    4) ./encrypt_ecc.sh "$input_file" "$output_file";;
    *) echo "$(tput setaf 1)Invalid choice$(tput sgr0)"; return 1;;
    esac
}

# Function to handle decryption
decrypt_file() {
    echo "$(tput bold)🔓 Enter the path of the file to decrypt:$(tput sgr0)"
    read -r input_file

    if [[ ! -f "$input_file" ]]; then
        echo "$(tput setaf 1)Error: File not found!$(tput sgr0)"
        return 1
    fi

    echo "$(tput bold)📁 Enter the path where you want to save the decrypted file:$(tput sgr0)"
    read -r output_file

    echo "$(tput bold)Choose the decryption algorithm:$(tput sgr0)"
    echo "$(tput setaf 14)1. AES$(tput sgr0)"
    echo "$(tput setaf 14)2. RSA$(tput sgr0)"
    echo "$(tput setaf 14)3. Camellia$(tput sgr0)"
    echo "$(tput setaf 14)4. ECC$(tput sgr0)"
    read -r choice

    case $choice in
    1) ./decrypt_aes.sh "$input_file" "$output_file";;
    2) ./decrypt_rsa.sh "$input_file" "$output_file";;
    3) ./decrypt_camellia.sh "$input_file" "$output_file";;
    4) ./decrypt_ecc.sh "$input_file" "$output_file";;
    *) echo "$(tput setaf 1)Invalid choice$(tput sgr0)"; return 1;;
    esac
}

# Function to handle key generation
generate_keys() {
    ./generate_key.sh
}

# Main program loop
while :
do
    display_menu

    echo "$(tput bold)👉 Enter your choice (1-4):$(tput sgr0)"
    read -r option

    case $option in
    1) encrypt_file;;
    2) decrypt_file;;
    3) generate_keys;;
    4) echo "$(tput bold)👋 Exiting program...$(tput sgr0)"; exit;;
    *) echo "$(tput setaf 1)Invalid choice$(tput sgr0)";;
    esac

    # Ask user if they want to perform another operation
    while true
    do
        echo "$(tput bold)🔄 Do you want to perform another operation? (yes/no)$(tput sgr0)"
        read -r do_more

        case $do_more in
        [Yy][Ee][Ss]) break;;
        [Nn][Oo]) echo "$(tput bold)👋 Exiting program...$(tput sgr0)"; exit;;
        *) echo "$(tput setaf 1)Please enter 'yes' or 'no'.$(tput sgr0)";;
        esac
    done
done






