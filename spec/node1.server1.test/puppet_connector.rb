RSpec.configure do |config|
  config.before do
    host = 'node1.server1.test'
    ssh_key = '/Users/johan.tique/code/codescrum/projects/bebox_all/bebox_demo/tmp/bebox-sample-puppet-generated-repo/config/environments/vagrant/keys/id_rsa'
    config.disable_sudo = true
    config.ssh.close if config.ssh
    config.host  = host
    options = Net::SSH::Config.for(config.host)
    options[:keys] = [ssh_key]
    options[:forward_agent] = true
    user = 'puppet'
    config.ssh   = Net::SSH.start(config.host, user, options)
  end
end