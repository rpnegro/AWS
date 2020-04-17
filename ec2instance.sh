#!/bin/bash

yum update -y
yum -y install httpd mysql
amazon-linux-extras install epel -y
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73
amazon-linux-extras install php7.3 -y
service httpd start
chkconfig httpd on
usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
echo "fs-71f7fef1.efs.us-east-1.amazonaws.com:/ /var/www/html nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab
mount -a
systemctl restart httpd
