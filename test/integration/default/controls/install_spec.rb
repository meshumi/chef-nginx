control 'install' do
  desc   'Ensure nginx is installed.'
  impact 1.0

  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe directory('/etc/nginx') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
  end

  describe directory('/var/log/nginx') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0750' }
  end

  %w(
    sites-available
    sites-enabled
    conf.d
    streams-available
    streams-enabled
  ).each do |leaf|
    directory("/etc/nginx/#{leaf}") do
      it { should exist }
      it { should be_directory }
      its('mode') { should cmp '0755' }
    end
  end

  %w(
    default.conf
    example_ssl.conf
  ).each do |config|
    file("/etc/nginx/conf.d/#{config}") do
      it { should_not exist }
    end
  end

  %w(
    nxensite
    nxdissite
    nxenstream
    nxdisstream
  ).each do |nxscript|
    describe file("/usr/sbin/#{nxscript}") do
      it { should exist }
      it { should be_file }
      its('mode') { should cmp '0755' }
      its('content') { should include "SYSCONFDIR='/etc/nginx'" }
    end
  end

  describe file('/etc/nginx/nginx.conf') do
    it { should exist }
    it { should be_file }
    its('content') { should include 'worker_processes 1;' }
    its('content') { should include 'pid        /var/run/nginx.pid;' }
    its('content') { should include 'worker_connections  1024;' }
    its('content') { should include 'keepalive_timeout  65;' }
    its('content') { should include 'types_hash_max_size 2048;' }
  end

  describe file('/etc/nginx/sites-available/default') do
    it { should exist }
    it { should be_file }
    its('content') { should include 'listen   80;' }
    its('content') { should include 'access_log  /var/log/nginx/localhost.access.log;' }
    its('content') { should include 'root   /var/www/nginx-default;' }
  end
end
