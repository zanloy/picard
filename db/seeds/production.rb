# frozen_string_literal: true
environments = [
  { name: 'Production', domain: 'vbms.vba.va.gov' },
  { name: 'Share', domain: 'shr.vbms.vba.va.gov' },
  { name: 'Prod-Test', domain: 'prdtst.vbms.vba.va.gov' },
  { name: 'Pre-Prod', domain: 'pre.vbms.vba.va.gov' },
  { name: 'Perf', domain: 'perf.vbms.vba.va.gov' },
  { name: 'All', domain: '' },
]

users.each { |user| User.create(user) } if defined?(users)
environments.each { |env| Environment.create(env) } if defined?(environments)
servers.each { |server| Server.create(server) } if defined?(servers)
engineering_changes.each { |change| EngineeringChange.create(change) } if defined?(engineering_changes)
