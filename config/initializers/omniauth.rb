Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_SECRET'],
    { hd: 'sparcedge.com' }

  if Rails.env.demo?
    use OmniAuth::Builder do
      configure do |config|
        config.path_prefix = '/picard/auth'
      end
    end
  end
end
