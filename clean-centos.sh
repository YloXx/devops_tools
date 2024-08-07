#!/bin/bash

if rpm -q yum-utils > /dev/null; then
  echo "Package yum-utils already installed. Good."
else
  echo "Going to install yum-utils..."
  yum -y install yum-utils
fi

echo 'Trimming .log files larger than 10MB...'
find /var -name "*.log" \( \( -size +10M -mtime +7 \) -o -mtime +30 \) -exec truncate {} --size 0 \;

echo "Cleaning yum caches..."
yum clean all
rm -rf /var/cache/yum
rm -rf /var/tmp/yum-*

echo "Removing WP-CLI caches..."
rm -rf /root/.wp-cli/cache/*
rm -rf /home/*/.wp-cli/cache/*

echo "Removing old Linux kernels..."
package-cleanup -y --oldkernels --count=1

echo "Removing Composer caches..."
rm -rf /root/.composer/cache
rm -rf /home/*/.composer/cache

echo "Removing core dumps..."
find -regex ".*/core\.[0-9]+$" -delete

echo "Removing cPanel error log files..."
find /home/*/public_html/ -name error_log -delete

echo "Removing Node.JS caches..."
rm -rf /root/.npm /home/*/.npm /root/.node-gyp /home/*/.node-gyp /tmp/npm-*

echo 'Removing mock caches...'
rm -rf /var/cache/mock/* /var/lib/mock/*

echo 'Removing user caches...'
rm -rf /home/*/.cache/* /root/.cache/*

echo 'Cleaning CustomBuild...'
rm -rf /usr/local/directadmin/custombuild_1.x

echo 'Cleaning all directadmin user/reseller backups'
rm -rf /home/backups/*

//echo 'searching for 10 biggest directories and files:'
//sudo du -a /home | sort -n -r | head -n 10

echo "All Done! grtz YloXx"
