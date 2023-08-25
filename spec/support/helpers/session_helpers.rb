module SessionHelpers
  def sign_in_with(user_attributes)
    sign_up_with(user_attributes) unless User.exists?(email: user_attributes[:email])

    visit sign_in_path

    fill_in 'Email', with: user_attributes[:email]
    fill_in 'Password', with: user_attributes[:password]

    click_button 'Sign in to your account'
  end

  def sign_out
    find_by_id('user-menu-button').click

    click_link 'Sign out'
  end

  def sign_up_with(user_attributes)
    visit sign_up_path

    fill_in 'First name', with: user_attributes[:first_name]
    fill_in 'Last name', with: user_attributes[:last_name]
    fill_in 'Email', with: user_attributes[:email]
    fill_in 'Password', with: user_attributes[:password]
    fill_in 'Password confirmation', with: user_attributes[:password_confirmation]
    check 'Terms of Service' if user_attributes[:terms_of_service]

    click_button 'Create your account'
  end
end

RSpec.configure do |config|
  config.include SessionHelpers, type: :system
end
