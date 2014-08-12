set(:deploy_via, :copy_subdir)
set(:deploy_subdir, 'puppet')
# Select options accord to the phase parameter
if phase == 'node_prepare'
	set :user, "vagrant"
	set :ssh_key, '~/.vagrant.d/insecure_private_key'
	set :copy_exclude, ['/profiles', '/roles', '/steps']
  set(:deploy_to) { "/home/vagrant/code" }
elsif phase == 'step-0'
  set :user, "vagrant"
  set :ssh_key, '~/.vagrant.d/insecure_private_key'
  set :copy_exclude, ['/lib', '/prepare', '/profiles', '/roles']
  set(:deploy_to) { "/home/vagrant/code" }
else
  set :user, "puppet"
  set :ssh_key, 'config/keys/environments/vagrant/id_rsa'
  set :copy_exclude, ['/lib', '/prepare', '/profiles', '/roles']
  set(:deploy_to) { "/home/puppet/code" }
end
# set :deploy_via, :copy
set :scm, :none
set :repository, "."


set :ssh_options, {
  :keys => ssh_key,
  :port => '22',
  :forward_agent => 'true'
}

# Start nodes definitions
  server "node1.server1.test", :web, :app, :db
# End nodes definitions

desc 'Test the vagrant connection by doing issuing a simple echo command'
task :probe, roles: [:web, :app, :db] do
  run 'echo $PATH'
end