# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  email              :string(128)      not null
#  first_name         :string(128)      not null
#  last_name          :string(128)      not null
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  password_digest    :string(72)       not null
#  preferences        :jsonb            not null
#  sign_in_count      :integer          default(0), not null
#  slug               :string(255)      not null
#  terms_of_service   :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email        (email) UNIQUE
#  index_users_on_preferences  (preferences) USING gin
#  index_users_on_slug         (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  describe 'inheritance' do
    subject { described_class }

    it { is_expected.to be <= FriendlyId }
  end

  describe 'attributes' do
    it { is_expected.to have_secure_password }
    it { is_expected.to have_attribute(:first_name) }
    it { is_expected.to have_attribute(:last_name) }
    it { is_expected.to have_attribute(:email) }

    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
  end

  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('invalid-email').for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:balances) }
  end
end
