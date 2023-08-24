class SignUpContract < BaseContract
  attribute :first_name, String
  attribute :last_name, String
  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :terms_of_service, Boolean
  attribute :creator, Boolean, default: false
  attribute :locale, String, default: 'en'
  attribute :time_zone, String, default: 'UTC'
  attribute :feed_name, String

  validates :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            presence: true
  validates :feed_name,
            presence: true,
            if: :creator?
  validates :password,
            confirmation: true
  validates :terms_of_service,
            acceptance: { allow: true }

  validate :validate_unique_email

  private

  def validate_unique_email
    errors.add(:email, :taken) if User.find_by(email:).present?
  end
end
