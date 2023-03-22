#!/bin/bash

# Define the domain to check
echo "DNS en server checker by YloXx"
echo "Fill in the domainname to check"
read domain

# Check if DirectAdmin is running
if ! pgrep -x "directadmin" > /dev/null
then
    echo "DirectAdmin is not running"
fi

# Check if Apache is running
if ! pgrep -x "httpd" > /dev/null
then
    echo "Apache is not running"
fi

# Check if PHP-FPM is running
if ! pgrep -x "php-fpm" > /dev/null
then
    echo "PHP-FPM is not running"
fi

# Check if the server is listening on IPv4 and IPv6
if ! netstat -tulpen | grep -E "0.0.0.0:80.*LISTEN.*httpd" > /dev/null
then
    echo "The server is not listening on IPv4 for HTTP requests"
fi

if ! netstat -tulpen | grep -E ":::80.*LISTEN.*httpd" > /dev/null
then
    echo "The server is not listening on IPv6 for HTTP requests"
fi

# Check if DNS records are valid
if ! named-checkzone "$domain" /etc/named.conf > /dev/null
then
    echo "DNS records for $domain are not valid"
fi

# Check the DNS MX record
echo "Checking the DNS MX record for $domain"
if ! host -t MX "$domain" > /dev/null
then
    echo "The DNS MX record for $domain is not valid"
fi

# Check the DNS A record
echo "Checking the DNS A record for $domain"
if ! host -t A "$domain" > /dev/null
then
    echo "The DNS A record for $domain is not valid"
fi

# Check the DNS AAAA record
echo "Checking the DNS AAAA record for $domain"
if ! host -t AAAA "$domain" > /dev/null
then
    echo "The DNS AAAA record for $domain is not valid"
fi

# Check the DNS TXT record
echo "Checking the DNS TXT record for $domain"
if ! host -t TXT "$domain" > /dev/null
then
    echo "The DNS TXT record for $domain is not valid"
fi
