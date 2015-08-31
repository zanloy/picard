users = [
  {
    email: 'admin@test.com',
    new_password: 'test123test123',
    name: 'Testing Admin',
    enabled: true,
    admin: true,
  },
  {
    email: 'test@test.com',
    new_password: 'test123test123',
    name: 'Tester McTesterson',
    enabled: true,
  },
]

environments = [
  { name: 'Production', domain: 'example.com' },
  { name: 'Pre-Prod', domain: 'pre.example.com' },
  { name: 'Dev', domain: 'dev.example.com' },
  { name: 'All', domain: '' },
]

engineering_changes = [
  {
    entered_by_id: 1,
    poc_id: 1,
    when: Time.zone.now,
    environment_id: 2,
    title: 'Fixed gparted error',
    description: %Q[The workstation had the following error:

[1]

I formatted the drive again and the error cleared.],
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-05-05 12:34 PM',
    environment_id: 1,
    title: 'Linux Patches #patching',
    description: 'yum clean all && yum update -y'
  },
  {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-02-02 14:00',
    environment_id: 3,
    title: 'Update #ansible hosts file to include new servers',
    description: 'Added www002.dev.example.com to hosts file.'
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
    environment_id: 4,
    title: 'Updated #splunk license and rebooted',
  }
]

10.times do |i|
  engineering_changes << {
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 12:34 PM',
    environment_id: rand(1..4),
    title: "Log Item #{i}",
  }
end

attachments = [
  {
    engineering_change_id: 1,
    reference: 1,
    file: File.new(Rails.root + 'spec/fixtures/images/error_msg.png')
  }
]

comments = [
  {
    commentable_id: 1,
    commentable_type: 'EngineeringChange',
    comment: 'Good job on this.',
    user_id: 2,
  }
]
users.each { |user| User.create(user) } if defined? users
environments.each { |env| Environment.create(env) } if defined? environments
engineering_changes.each { |change| EngineeringChange.create(change) } if defined? engineering_changes
attachments.each { |attachment| Attachment.create(attachment) } if defined? attachments
comments.each { |comment| Comment.create(comment) } if defined? comments
