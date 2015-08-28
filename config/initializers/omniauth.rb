Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.demo?
    full_host = 'http://demo.zanloy.com/picard'
  end

  provider :google_oauth2,
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_SECRET'],
    { hd: 'sparcedge.com' }

end
