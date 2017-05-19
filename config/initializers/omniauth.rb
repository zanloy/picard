# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.demo?
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET']
  else
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'], { hd: 'sparcedge.com' }
    provider :slack, ENV['SLACK_APPID'], ENV['SLACK_SECRET'], scope: 'identity.basic, identity.avatar, identity.email, identity.team', team: 'T02UXS1N2'
  end
end
