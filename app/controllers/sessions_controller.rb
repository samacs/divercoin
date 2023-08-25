class SessionsController < ApplicationController
  expose :user, fetch: -> { User.find_by(email: session_params[:email]) }

  skip_before_action :require_user, except: :destroy

  before_action :require_no_user, except: :destroy

  def create
    if user&.authenticate(session_params[:password])
      sign_in!(user)

      return redirect_to root_path
    end

    render turbo_stream: turbo_replace_flash(t('.wrong_credentials'), :warning)
  end

  def destroy
    sign_out!

    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
