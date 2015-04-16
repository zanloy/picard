# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w[Production Share All Prod-Test Pre-Prod Perf].each do |env|
  Environment.create(name: env)
end

users = [ { email: 'zan.loy@sparcedge.com', new_password: 'test', enabled: true, admin: true } ]
users.each { |user| User.create(user) }

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
    when: '2015-01-01 14:40'
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

log_items.each { |log_item| LogItem.create(log_item) }
