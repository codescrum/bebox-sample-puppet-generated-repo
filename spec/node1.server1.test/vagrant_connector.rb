RSpec.configure do |config|
  config.before do
    host = 'node1.server1.test'
    ssh_key = '~/.vagrant.d/insecure_private_key'
    config.disable_sudo = true
    config.ssh.close if config.ssh
    config.host  = host
    options = Net::SSH::Config.for(config.host)
    options[:keys] = [ssh_key]
    options[:forward_agent] = true
    user = 'vagrant'
    config.ssh   = Net::SSH.start(config.host, user, options)
  end
end