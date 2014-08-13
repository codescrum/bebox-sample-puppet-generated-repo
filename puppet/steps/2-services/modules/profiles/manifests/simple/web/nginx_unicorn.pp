# **************************************************
# Nginx-Unicorn profile for zero downtime deployment
# **************************************************
#
# Using jfryman-nginx module modified with a
# temporary fix for future parser issue PUP-2731
# in puppet/steps/2-services/modules/nginx
#
# Vhost, upstream and location are loaded internally
# for the nginx module through hiera parameters
#
# Hiera parameters:
#
# nginx::nginx_upstreams:
#   'simple_web_app':
#     members:
#       - 'unix:/tmp/simple_web_app.socket'
# nginx::nginx_vhosts:
#   'simple_web_app.server1.test':
#     ensure: 'present'
#     listen_port:  80
#     www_root: '/home/simple_web_app/code/current/public'
#     access_log: '/var/log/nginx/simple_web_app_access.log'
#     error_log: '/var/log/nginx/simple_web_app_error.log'
#     ssl: false
#     use_default_location: false
# nginx::nginx_locations:
#   '/':
#     ensure: present
#     vhost: 'simple_web_app.server1.test'
#     proxy: 'http://simple_web_app'

class profiles::simple::web::nginx_unicorn {

  # **************************************************
  # Set nginx configuration parameters.
  # mainly /etc/nginx/nginx.conf
  # **************************************************

  class { '::nginx':
    daemon_user => 'simple_web_app',
    worker_processes => 4,
    gzip => on,
    pid => '/var/run/nginx.pid',
    worker_connections => 1024,
    multi_accept => on,
    sendfile => on,
    http_tcp_nopush => on,
    http_tcp_nodelay => off,
    proxy_redirect => off,
    proxy_set_header => [
        'Host $host',
        'X-Real-IP $remote_addr',
        'X-Forwarded-For $proxy_add_x_forwarded_for',
      ],
    client_max_body_size => '10m',
    client_body_buffer_size => '128k',
    proxy_connect_timeout => '90',
    proxy_send_timeout => '90',
    proxy_read_timeout => '90',
    proxy_buffer_size => '4k',
    proxy_buffers => '4 32k',
  }

  # ************************************************
  # Unicorn service creation
  #
  # Using custom unicorn module in
  # puppet/steps/2-services/modules/unicorn
  # ************************************************
  class { '::unicorn':
    user => 'simple_web_app',
    appname => 'simple_web_app',
    approot => '/home/simple_web_app/code/current',
  }
}