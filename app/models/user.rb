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
class User < ApplicationRecord
  include FriendlyId
  include Sessionable

  attr_reader :password_changed

  rolify

  has_many :balances, dependent: :destroy

  scope :by_email, ->(email) { where(email:) }
  scope :with_balances, -> { includes(:balances) }

  has_secure_password
  has_person_name

  friendly_id :email_username

  validates :first_name,
            :last_name,
            presence: true
  validates :email,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_confirmation,
            presence: true,
            if: :password_changed?
  validates :terms_of_service,
            acceptance: { accepts: true },
            allow_nil: false,
            on: :create

  before_validation :downcase_email

  def password=(value)
    @password_changed = true

    super
  end

  def to_s = name

  private

  def email_username = email&.split('@')&.first

  def downcase_email
    email.downcase! if email.present?
  end

  def password_changed? = password_changed || false
end
