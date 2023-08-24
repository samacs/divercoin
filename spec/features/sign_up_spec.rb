require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  subject { page }

  before { visit sign_up_path }

  describe 'GET /sign-up' do
    it { is_expected.to have_current_path '/sign-up' }
    it { is_expected.to have_field('First name') }
    it { is_expected.to have_field('Last name') }
    it { is_expected.to have_field('Email') }
    it { is_expected.to have_field('Password') }
    it { is_expected.to have_field('Password confirmation') }
    it { is_expected.to have_field('Terms of Service') }
    it { is_expected.to have_button('Create your account') }
    it { is_expected.to have_link('Already have an account?') }
  end

  describe 'POST /sign-up' do
    let(:user_attributes) do
      attributes_for(:user)
    end

    before do
      fill_in('First name', with: user_attributes[:first_name])
      fill_in('Last name', with: user_attributes[:last_name])
      fill_in('Email', with: user_attributes[:email])
      fill_in('Password', with: user_attributes[:password])
      fill_in('Password confirmation', with: user_attributes[:password_confirmation])
      check 'Terms of Service' if user_attributes[:terms_of_service]
    end

    context 'when the values are valid' do
      it { expect { click_button 'Create your account' }.to change(User, :count).by(1) }
    end

    context 'when the user is created' do
      let(:expected_message) do
        "Welcome, #{user_attributes[:first_name]} #{user_attributes[:last_name]}! Your account has been created."
      end

      before { click_button 'Create your account' }

      it { is_expected.to have_current_path root_path }
      it { is_expected.to have_content expected_message }
    end

    context 'when the values are invalid', js: true do
      let(:user_attributes) { {} }

      before { click_button 'Create your account' }

      it { is_expected.to have_content '6 errors occurred' }
      it { is_expected.to have_content "First name can't be blank" }
      it { is_expected.to have_content "Last name can't be blank" }
      it { is_expected.to have_content 'Email is invalid' }
      it { is_expected.to have_content "Password confirmation can't be blank" }
      it { is_expected.to have_content "Password can't be blank" }
    end
  end
end
