nginxUser:
''
  listen = 127.0.0.1:9000
  listen.owner = ${nginxUser}
  listen.group = ${nginxUser}
  user = ${nginxUser}
  pm = dynamic
  pm.max_children = 75
  pm.start_servers = 10
  pm.min_spare_servers = 5
  pm.max_spare_servers = 20
  pm.max_requests = 500
''
