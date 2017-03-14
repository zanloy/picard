# frozen_string_literal: true
# Users
[
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
].each { |user| User.create(user) }

# Environments
[
  { name: 'Production', domain: 'example.com' },
  { name: 'Pre-Prod', domain: 'pre.example.com' },
  { name: 'Dev', domain: 'dev.example.com' },
  { name: 'All', domain: '' },
].each { |env| Environment.create(env) }

# Changes
[
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
].each { |change| EngineeringChange.create(change) }

10.times do |i|
  EngineeringChange.create({
    entered_by_id: 1,
    poc_id: 1,
    when: '2015-01-01 12:34 PM',
    environment_id: rand(1..4),
    title: "Random Log Item #{i}",
  })
end

# Attachments
[
  {
    engineering_change_id: 1,
    reference: 1,
    file: File.new(Rails.root + 'spec/fixtures/images/error_msg.png'),
  }
].each { |attachment| Attachment.create(attachment) }

# Comments
[
  {
    commentable_id: 1,
    commentable_type: 'EngineeringChange',
    comment: 'Good job on this.',
    user_id: 2,
  }
].each { |comment| Comment.create(comment) }

# Certificates
FactoryGirl.create(:certificate)

# Lists
[
  {
    name: 'Software Versions',
    schema: '{ "name": "string", "version": "string", "eol": "datetime" }',
  }
].each { |list| List.create(list) }

# List Items
[
  {
    list: List.first,
    name: "Ruby",
    version: "v1.9.2",
    eol: "2014-07-31",
  }
].each { |list_item| ListItem.create(list_item) }
