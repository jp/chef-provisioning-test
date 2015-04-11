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


