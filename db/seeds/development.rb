users = [
  {
    email: 'zan.loy@gmail.com',
    new_password: 'test',
    name: 'Zan Gmail',
    enabled: true,
    admin: false,
  }
]

environments = [
  { name: 'Production', domain: 'vbms.vba.va.gov' },
  { name: 'Share', domain: 'shr.vbms.vba.va.gov' },
  { name: 'Prod-Test', domain: 'prdtst.vbms.vba.va.gov' },
  { name: 'Pre-Prod', domain: 'pre.vbms.vba.va.gov' },
  { name: 'Perf', domain: 'perf.vbms.vba.va.gov' },
  { name: 'All', domain: '' },
]

engineering_changes = [
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 12:34 PM',
    environment_id: 1,
    title: 'Linux Patches',
    description: 'yum clean all && yum update -y'
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-02-02 14:00',
    environment_id: 2,
    title: 'Update Ansible hosts file to include new servers',
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 14:40',
    environment_id: 1,
    title: 'Restart all servers',
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2013-12-25',
    environment_id: 2,
    title: 'Updated Splunk license and rebooted',
  }
]

50.times do |i|
  engineering_changes << {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 12:34 PM',
    environment_id: rand(1..6),
    title: "Log Item ##{i}",
  }
end

users.each { |user| User.create(user) } if defined?(users)
environments.each { |env| Environment.create(env) } if defined?(environments)
engineering_changes.each { |change| EngineeringChange.create(change) } if defined?(engineering_changes)
