#!/bin/bash

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
if ! named-checkzone example.com /etc/named.conf > /dev/null
then
    echo "DNS records for example.com are not valid"
fi
