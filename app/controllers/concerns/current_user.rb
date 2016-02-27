module CurrentUser
  extend ActiveSupport::Concern

  included do
    before_filter :check_for_user
  end

  def current_user
    @current_user
  end

private
  def check_for_user
    id = session_user_id || remember_me
    begin
      if id
        @current_user = User.find(id)

        # force re-login if user has no image yet
        @current_user = nil unless session_user_id || @current_user.has_image?
      end
    rescue
      logger.info "User_ID #{id} from session or cookie invalid"
    end
  end

  def remember_me
    cookies.signed[:remember_user]
  end

  def remember_me=(value)
    logger.info "Setting remember_me cookie to #{value}"
    cookies.signed[:remember_user] = { value: value, expires: 2.months.from_now }
  end

  def session_user_id
    session[:user_id]
  end

  def session_user_id=(value)
    logger.info "Setting session_user_id to #{value}"
    session[:user_id] = value
  end
end