#!/bin/bash

for user in $(ls /usr/local/directadmin/data/users)
do
    user_domain=$(grep "^${user}:" /usr/local/directadmin/data/users/$user/user.conf | cut -d= -f2 | cut -d, -f1)
    user_ip=$(grep "^ip=" /usr/local/directadmin/data/users/$user/user.conf | cut -d= -f2)
    user_reverse_zone=$(echo $user_ip | awk -F. '{print $3"."$2"."$1".in-addr.arpa"}')
    echo "Setting up Reverse DNS for user $user_domain ($user_ip)"

    # Add Reverse DNS Zone
    /usr/local/directadmin/scripts/create_reverse_dns.sh $user_domain $user_ip

    # Add PTR record
    /usr/local/directadmin/scripts/add_reverse_dns.sh $user_domain $user_reverse_zone $user_ip
done
