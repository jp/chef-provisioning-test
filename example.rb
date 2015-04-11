require 'chef/provisioning/docker_driver'

with_chef_server "https://api.opscode.com/organizations/pupz",
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]

machine_image 'web' do
  recipe 'nginx'
  recipe 'nodejs::nodejs_from_source'
  recipe 'pup'

  machine_options :docker_options => {
      :base_image => {
          :name => 'ubuntu',
          :repository => 'ubuntu',
          :tag => '14.04'
      }
  }
end

machine 'web00' do
  from_image 'web'

  machine_options :docker_options => {
      :command => 'service nginx start'
  }
end

