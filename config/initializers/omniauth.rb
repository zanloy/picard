Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_SECRET'],
    { hd: 'sparcedge.com' }

  if Rails.env.demo?
    provider :google_oauth2, callback_path: '/picard/auth/google_oauth2/callback'
  end
end
