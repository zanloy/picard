# frozen_string_literal: true
users = [
  {
    email: 'zan.loy@gmail.com',
    new_password: 'test',
    name: 'Zan Gmail',
    enabled: true,
    admin: false,
  }
]

users.each { |user| User.create(user) } if defined?(users)
environments.each { |env| Environment.create(env) } if defined?(environments)
servers.each { |server| Server.create(server) } if defined?(servers)
engineering_changes.each { |change| EngineeringChange.create(change) } if defined?(engineering_changes)
