# == Schema Information
#
# Table name: currencies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  price      :decimal(8, 2)    default(0.0), not null
#  status     :enum             default("inactive")
#  ticker     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  asset_id   :string
#
# Indexes
#
#  index_currencies_on_ticker  (ticker) UNIQUE
#
require 'rails_helper'

RSpec.describe Currency, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
