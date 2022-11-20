Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :twitter2, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], callback_path: '/auth/twitter2/callback', scope: "tweet.read users.read"
end