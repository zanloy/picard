servers = [
  {
    name: 'extpxy001',
    environment_id: 1,
    ip_address: 'x.x.1.100',
    ports: '22/tcp, 443/tcp',
  },
  {
    name: 'extpxy002',
    environment_id: 1,
    ip_address: 'x.x.1.102',
    ports: '22/tcp, 443/tcp',
  }
]

log_items = [
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 12:34 PM',
    environment_id: 1,
    name: 'Linux Patches',
    description: 'yum clean all && yum update -y'
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-02-02 14:00',
    environment_id: 2,
    name: 'Update Ansible hosts file to include new servers',
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 14:40',
    environment_id: 1,
    name: 'Restart all servers',
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2013-12-25',
    environment_id: 2,
    name: 'Updated Splunk license and rebooted',
  }
]

users.each { |user| User.create(user) } if defined?(users)
environments.each { |env| Environment.create(env) } if defined?(environments)
servers.each { |server| Server.create(server) } if defined?(servers)
log_items.each { |log_item| LogItem.create(log_item) } if defined?(log_items)
