#!/bin/bash

# Check if the nslookup command is available
if ! command -v nslookup &> /dev/null; then
    echo "Error: the 'nslookup' command is not available. Please install it and try again."
    exit 1
fi

# Prompt the user for the domain and DNS server
read -p "Please enter the domain(s) (separated by space): " domain_input
read -p "Please enter the DNS server (press Enter to use the default DNS): " dns_server

# Check if at least one domain was entered
if [ -z "$domain_input" ]; then
    echo "No domain was entered. Usage: $0 <domain1> <domain2> ..."
    exit 1
fi

# Convert user input into a list of arguments
set -- $domain_input

# Variable to store the results
log_output=""

# Iterate over each provided domain
for domain in "$@"; do
    echo "Querying DNS for: $domain"
    
    # Execute nslookup and capture the output
    if [ -z "$dns_server" ]; then
        nslookup_output=$(nslookup "$domain" 2>&1)
    else
        nslookup_output=$(nslookup "$domain" "$dns_server" 2>&1)
    fi
    
    # Check if nslookup was successful
    if [ $? -eq 0 ]; then
        echo "nslookup result for $domain:"
        echo "$nslookup_output"
        log_output+="nslookup result for $domain:\n$nslookup_output\n"
    else
        echo "Error querying $domain"
        echo "$nslookup_output"
        log_output+="Error querying $domain:\n$nslookup_output\n"
    fi
    
    echo "-----------------------------------"
    log_output+="-----------------------------------\n"
done

# Save the result to a log file
read -p "Do you want to save the result to a log file? (y/n): " save_log

if [ "$save_log" == "y" ]; then
    # Get the current date and time
    current_date=$(date +"%d-%m-%Y_%H-%M-%S")
    log_file="nslookup_log_$current_date.txt"
    
    # Save the result to the log file
    echo -e "$log_output" > "$log_file"
    echo "Result saved in $log_file"
fi