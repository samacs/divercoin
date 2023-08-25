require 'rails_helper'

RSpec.describe 'Balances', type: :system do
  describe 'GET /balances/new' do
    context 'when the user is not signed in' do
      subject { page }

      before { visit new_balance_path }

      it { is_expected.to have_current_path root_path }
      it { is_expected.to have_content 'User not signed in' }
    end

    context 'when the user is signed in' do
      let(:user) { create(:user) }

      before do
        visit sign_in_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_button 'Sign in to your account'

        visit new_balance_path
      end

      it 'shows the form to add a new balance' do
        expect(page).to have_current_path '/balances/new'
        expect(page).to have_field 'Reference'
        expect(page).to have_field 'Amount'
        expect(page).to have_button 'Add balance'
        expect(page).to have_link 'Cancel', href: portfolio_path
      end

      context 'when the user creates a new balance' do
        let(:balance_attributes) { attributes_for(:balance) }

        it 'creates the balance and redirects to the portfolio page' do
          fill_in 'Reference', with: balance_attributes[:reference]
          fill_in 'Amount', with: balance_attributes[:amount]

          expect { click_button('Add balance') }.to change(user.balances, :count).by(1)
        end
      end
    end
  end
end
