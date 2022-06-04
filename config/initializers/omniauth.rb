Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if ENV['NONAUTH']
  provider :oauth, ENV.fetch('APP_ID','123456'), ENV.fetch('APP_SECRET','secret') unless Rails.env.test?
end
