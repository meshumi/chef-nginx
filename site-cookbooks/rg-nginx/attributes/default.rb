include_attribute 'nginx::source'

override['nginx']['source']['version'] = '1.13.7'
override['nginx']['source']['checksum'] = 'beb732bc7da80948c43fd0bf94940a21a21b1c1ddfba0bd99a4b88e026220f5c'
override['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
override['users']['system']['nginx']['name'] = 'nginx'
override['users']['system']['nginx']['group'] = 'www-data'
override['users']['system']['nginx']['home'] = false

default['project']['user'] = default['users']['system']['application']['name']
default['project']['group'] = default['users']['system']['application']['group']
default['project']['root'] = File.join('/home', 'deployer', node['domain'].to_s)

source = node['nginx']['source']
user = node['users']['system']['nginx']

override['nginx']['install_method'] = 'source'
override['nginx']['version'] = source['version']
override['nginx']['source']['prefix'] = "/opt/nginx-#{source['version']}"
override['nginx']['source']['sbin_path'] = "#{source['prefix']}/sbin/nginx"
override['nginx']['binary'] = source['sbin_path']
override['nginx']['init_style'] = 'systemd'
override['nginx']['user'] = user['name']
override['nginx']['group'] = user['group']

override['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{source['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{source['sbin_path']}
)

override['nginx']['source']['modules'] = %w(
  nginx::http_gzip_static_module
  nginx::http_ssl_module
)

override['nginx']['configure_flags'] = %w(
  --with-debug
)

override['nginx']['default_site_enabled'] = false
