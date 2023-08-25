require 'rails_helper'

RSpec.describe 'Sign out', type: :system do
  subject { page }

  describe 'GET /sign-out' do
    context 'when the user is not signed in' do
      before { visit '/sign-out' }

      it { is_expected.to have_content(/not found/i) }
    end
  end

  describe 'DELETE /sign-out' do
    let(:user_attributes) { attributes_for(:user) }
    let(:user) { User.find_by(email: user_attributes[:email]) }

    before { sign_in_with(user_attributes) }

    it 'performs the sign out' do
      sign_out

      expect(page).not_to have_selector('#user-menu-button')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Get started')
    end
  end
end
