class AuthService

  def handle_auth_success(auth_hash)
    # see https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    uid = auth_hash[:uid]
    provider = auth_hash[:provider]
    user = User.find_by(social_id: uid, auth_provider: provider) || User.find_by(social_id: uid)
    user = User.new(social_id: uid, role: 'guest') unless user
    info = auth_hash[:info]
    user.common_name = info[:name]
    user.email = info[:email]
    user.auth_provider = provider

    user.save!

    user
  end

end