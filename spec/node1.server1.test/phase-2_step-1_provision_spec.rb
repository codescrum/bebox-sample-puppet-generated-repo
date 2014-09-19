require 'spec_helper'
require_relative 'puppet_connector.rb'

describe 'Phase-2, Step-1: Apply provision for users layer' do

  let(:provision) { build(:provision, step: 'step-1') }

  describe user('sample-puppet-generated-repo') do
    it { should exist }
    it { should belong_to_group 'root' }
    it { should have_home_directory '/home/sample-puppet-generated-repo' }
    it { should have_login_shell '/bin/bash' }
    it { should have_uid 7001 }
  end

  describe file('/home/sample-puppet-generated-repo/.ssh/authorized_keys') do
    let(:disable_sudo) { false }
    it { should be_file }
    its(:content) {
      keys_content = File.read("#{Dir.pwd}/config/environments/vagrant/keys/id_rsa.pub").strip
      should == "#{keys_content}"
    }
  end
end