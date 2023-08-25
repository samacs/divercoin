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
FactoryBot.define do
  factory :balance do
    reference { Faker::Commerce.promotion_code }
    amount { Faker::Commerce.price }

    user
  end
end
