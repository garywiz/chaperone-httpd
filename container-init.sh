#!/bin/bash

thisuser=${USER:-apache}

echo executing chown -R $thisuser:apache /var/log/httpd /run/httpd
sudo chown -R $thisuser:apache /var/log/httpd /run/httpd
