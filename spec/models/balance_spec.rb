# == Schema Information
#
# Table name: balances
#
#  id         :bigint           not null, primary key
#  amount     :decimal(8, 2)    default(0.0), not null
#  reference  :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_balances_on_user_id           (user_id)
#  index_balances_on_user_id_and_slug  (user_id,slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Balance do
  describe 'inheritance' do
    subject { described_class }

    it { is_expected.to be <= FriendlyId }
  end

  describe 'attributes' do
    it { is_expected.to have_attribute(:amount) }
    it { is_expected.to have_attribute(:reference) }
  end

  describe 'validations' do
    subject(:balance) { build(:balance) }

    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
