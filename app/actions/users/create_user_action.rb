module Users
  class CreateUserAction < BaseAction
    expects :first_name, :last_name, :email, :password, :password_confirmation, :terms_of_service

    promises :user

    executed do |ctx|
      ctx.user = User.new(ctx.slice(*expected_keys))
      ctx.fail_and_return!(ctx.user.errors, error_code: :unprocessable_entity) unless ctx.user.save
    end
  end
end
