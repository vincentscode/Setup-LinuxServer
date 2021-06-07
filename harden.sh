#!/bin/bash

# Sources:
# https://opensource.com/article/19/10/linux-server-security
# 

echo "Update"
apt update && apt upgrade -y

echo "Add admin user"
adduser admin
usermod -a -G sudo admin

echo "Secure sshd"
echo "	PasswordAuthentication no"
echo "	PermitRootLogin no"
nano /etc/ssh/sshd_config

echo "Restart sshd"
service sshd restart

echo "Install & configure ufw"
apt install ufw -y
ufw allow ssh
ufw enable
ufw status

echo "Install & configure fail2ban"
apt install fail2ban -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
service fail2ban restart
fail2ban-client status ssh