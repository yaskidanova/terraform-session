#!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<html><body><h1>Session-2 homework is complete! </h1></body></html>" > /var/www/html/index.html