class ApplicationController < ActionController::Base
  include Pundit::Authorization

  include SessionManagement
  include TurboManagement

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_flash_types :success, :warning, :error

  def user_not_authorized = redirect_back_or_to root_path, warning: t('not_authorized')
end
