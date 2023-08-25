require 'rails_helper'

RSpec.describe 'Sign in', type: :system do
  subject { page }

  before { visit sign_in_path }

  describe 'GET /sign-in' do
    it { is_expected.to have_title(/sign in/i) }
    it { is_expected.to have_current_path '/sign-in' }
    it { is_expected.to have_field('Email') }
    it { is_expected.to have_field('Password') }
    it { is_expected.to have_button('Sign in to your account') }
    it { is_expected.to have_link("Don't have an account?", href: sign_up_path) }
  end

  describe 'POST /sign-in', js: true do
    let(:user) { create(:user) }
    let(:sign_in_button) { 'Sign in to your account' }
    let(:expected_error) { /please check your credentials/i }

    context 'when the credentials are empty' do
      before { click_button(sign_in_button) }

      it { is_expected.to have_current_path '/sign-in' }
      it { is_expected.to have_content expected_error }
    end

    context 'when the user is not found' do
      before do
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Password', with: Faker::Internet.password

        click_button(sign_in_button)
      end

      it { is_expected.to have_current_path '/sign-in' }
      it { is_expected.to have_content expected_error }
    end

    context 'when the user password is incorrect' do
      let(:user) { create(:user) }
      let(:password) { Faker::Internet.password }

      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: password

        click_button sign_in_button
      end

      it { is_expected.to have_current_path '/sign-in' }
      it { is_expected.to have_content expected_error }
    end

    context 'when the credentials are valid' do
      let(:user_attributes) { attributes_for(:user) }
      let(:user) { User.find_by(email: user_attributes[:email]) }

      before do
        sign_up_with(user_attributes)

        visit sign_in_path

        fill_in 'Email', with: user_attributes[:email]
        fill_in 'Password', with: user_attributes[:password]
      end

      it 'the use is authenticatedsigns the user in' do
        click_button sign_in_button

        expect(page).to have_current_path root_path

        expect(user.sign_in_count).to be 1
        expect(user.current_sign_in_at).not_to be_nil
        expect(user.current_sign_in_ip).not_to be_nil

        # TODO: Check for user session information
      end
    end
  end
end
