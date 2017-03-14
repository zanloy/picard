# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.demo?
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET']
  else
    provider :google_oauth2,
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_SECRET'],
      { hd: 'sparcedge.com' }
  end
end
