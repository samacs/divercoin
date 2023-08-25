class UsersController < ApplicationController
  skip_before_action :require_user

  before_action :require_no_user

  def create
    result = SignUpService.call(user_params)
    return render turbo_stream: turbo_replace_form(user: result.user) if result.failure?

    sign_in!(result.user)

    redirect_to root_path, success: t('.success', user: result.user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :terms_of_service)
  end
end
