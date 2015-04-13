#
# Cookbook Name:: pup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w'nginx'.each do | pack |
  package pack do
    action :install
  end
end

execute "set 'daemon off' for nginx" do
  command "sed -i '1s/^/daemon off;\\n/' /etc/nginx/nginx.conf"
  not_if "grep 'daemon off' /etc/nginx/nginx.conf"
end

