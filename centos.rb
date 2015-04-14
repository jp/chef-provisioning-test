require 'chef/provisioning/docker_driver'

with_chef_server "https://api.opscode.com/organizations/pupz",
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

machine_image 'centos_nodejs' do
  recipe 'tar'
  recipe 'redisio'
#  recipe 'mongodb'
  recipe 'pup::backend'
  recipe 'pup::frontend'

  attributes :nodejs => {
    :version => '0.12.2',
    :source => {
      :checksum => 'ac7e78ade93e633e7ed628532bb8e650caba0c9c33af33581957f3382e2a772d'
    }
  }

  machine_options :docker_options => {
      :base_image => {
          :name => 'centos',
          :repository => 'centos',
          :tag => '7'
      }
  }
end

machine 'web00' do
  from_image 'centos_nodejs'

  machine_options :docker_options => {
      :command => '/usr/sbin/nginx',
      :ports => ["8000:80"]
  }
end

machine 'pup_redis' do
  from_image 'centos_nodejs'

  machine_options :docker_options => {
      :command => '/usr/local/bin/redis-server',
      :ports => ["6379:6379"]
  }
end

