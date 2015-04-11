require 'chef/provisioning/docker_driver'

with_chef_server "https://api.opscode.com/organizations/pupz",
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

machine_image 'centos_nodejs' do
  recipe 'tar'
  recipe 'nodejs::nodejs_from_source'
  recipe 'pup'

  attributes :nodejs => {
    :version => '0.12.2'
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
      :command => 'service nginx start'
  }
end

