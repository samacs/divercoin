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
      let(:user_attributes) { attributes_for(:user) }
      let(:user) { User.find_by(email: user_attributes[:email]) }

      before do
        sign_up_with(user_attributes)
        sign_in_with(user_attributes)

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

        it 'creates the balance and redirects to the portoflio' do
          fill_in 'Reference', with: balance_attributes[:reference]
          fill_in 'Amount', with: balance_attributes[:amount]

          expect { click_button('Add balance') }.to change(user.balances, :count).by(1)

          expect(page).to have_current_path '/portfolio'
          expect(page).to have_content balance_attributes[:reference]
          expect(page).to have_content balance_attributes[:amount]
        end
      end

      context 'when the balance attributes are invalid' do
        let(:balance_attributes) { attributes_for(:balance, amount: 0.0) }

        it 'shows the validation errors' do
          fill_in 'Reference', with: balance_attributes[:reference]
          fill_in 'Amount', with: balance_attributes[:amount]

          expect { click_button('Add balance') }.not_to change(user.balances, :count)
        end
      end
    end
  end
end
