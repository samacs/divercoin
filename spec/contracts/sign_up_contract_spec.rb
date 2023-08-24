require 'rails_helper'

RSpec.describe SignUpContract do
  subject(:contract) { described_class.new attributes }

  before { contract.validate }

  context 'when the attributes are valid' do
    let(:attributes) { attributes_for(:user) }

    it { is_expected.to be_valid }
  end

  context 'when the attributes are invalid' do
    let(:attributes) { attributes_for(:user, first_name: '') }
    let(:expected_errors) { ["First name can't be blank"] }

    it { is_expected.not_to be_valid }
    its('errors.full_messages') { is_expected.to match expected_errors }
  end

  context 'when the user already exists' do
    let(:user) { create(:user) }
    let(:attributes) { attributes_for(:user, email: user.email) }
    let(:expected_errors) { ['Email has already been taken'] }

    it { is_expected.not_to be_valid }
    its('errors.full_messages') { is_expected.to match expected_errors }
  end
end
