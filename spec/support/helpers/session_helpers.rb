#!/usr/bin/env ruby
module SessionHelpers
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
