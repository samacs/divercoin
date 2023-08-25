require 'rails_helper'

module Users
  RSpec.describe CreateUserAction do
    subject(:result) { described_class.execute(context) }

    let(:context) { LightService::Context.make(params) }

    context 'when the context is valid' do
      let(:params) { attributes_for(:user) }

      it { is_expected.to be_success }
      its(:user) { is_expected.to be_persisted }
    end

    context 'when the context is invalid' do
      let(:params) do
        { first_name: '', last_name: '', email: '', password: '', password_confirmation: '', terms_of_service: '' }
      end
      let(:expected_errors) do
        [
          "Password can't be blank",
          "First name can't be blank",
          "Last name can't be blank",
          'Email is invalid',
          "Password confirmation can't be blank",
          'Terms of service must be accepted'
        ]
      end

      it { is_expected.to be_failure }

      its('message.full_messages') { is_expected.to match expected_errors }
    end
  end
end
