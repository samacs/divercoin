class UsersController < ApplicationController
  def create
    result = SignUpService.call(user_params)
    return render turbo_stream: turbo_replace_form(user: result.user) if result.failure?

    redirect_to root_path, success: t('.success', user: result.user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :terms_of_service)
  end
end