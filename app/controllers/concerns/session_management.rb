module SessionManagement
  extend ActiveSupport::Concern

  included do
    before_action :require_user

    helper_method :current_user, :signed_in?
  end

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session.key?(:user_id)
  end

  def sign_in!(user)
    user.sign_in!(request.remote_ip)

    session[:user_id] = user.id
  end

  def sign_out!
    current_user.sign_out!

    reset_session
  end

  def signed_in? = current_user.present?

  def require_user
    return if signed_in?

    redirect_back_or_to root_path, warning: t('not_signed_in', scope: 'session_management')
  end

  def require_no_user
    redirect_back_or_to root_path if signed_in?
  end
end
