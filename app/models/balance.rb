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
class Balance < ApplicationRecord
  include FriendlyId

  belongs_to :user

  friendly_id :reference

  validates :reference,
            presence: true
  validates :amount,
            numericality: { greater_than: 0.0 }

  scope :newer, -> { order(id: :desc) }

  def to_s = reference

  def profit_at(profit, month) = (amount * ((1 + (profit / 100.0))**month)) - amount
end
