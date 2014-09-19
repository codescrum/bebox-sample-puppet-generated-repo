require 'spec_helper'
require_relative '../factories/node.rb'
require_relative 'vagrant_connector.rb'

describe 'Phase-1: Node prepared' do

  let(:node) { build(:node, hostname: 'node1.server1.test', ip: '192.168.0.81') }

  describe interface('eth1') do
    it { should have_ipv4_address(node.ip) }
  end

  describe host('node1.server1.test') do
    it { should be_resolvable }
    it { should be_reachable.with( :port => 22 ) }
  end

  describe user('vagrant') do
    it { should exist }
  end

  describe command('hostname') do
    it 'should configure the hostname' do
      should return_stdout node.hostname
    end
  end

  describe command("dpkg -s git-core build-essential curl whois openssl libxslt1-dev autoconf bison libreadline5 libsqlite3-dev | grep Status") do
    it 'should install ubuntu dependencies' do
      should return_stdout /(Status: install ok installed\s*){10}/
    end
  end

  describe package('puppet') do
    it { should be_installed }
  end

end