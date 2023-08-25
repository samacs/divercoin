require 'rails_helper'

RSpec.describe SignUpService do
  subject(:result) { described_class.call(context) }

  describe 'actions' do
    let(:actions) { [Users::CreateUserAction] }

    context 'when the context is valid' do
      let(:context) { attributes_for(:user) }

      it 'executes the required actions' do
        actions.each { |action| allow(action).to receive(:execute) }

        result

        expect(actions).to all(have_received(:execute))
      end

      it { expect { result }.to change(User, :count).by(1) }
    end

    context 'when the context is invalid' do
      let(:context) { attributes_for(:user, first_name: '') }
      let(:expected_errors) { ["First name can't be blank"] }

      it { is_expected.to be_failure }
      its('message.full_messages') { is_expected.to match(expected_errors) }
    end
  end
end
