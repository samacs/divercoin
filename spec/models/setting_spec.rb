# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
require 'rails_helper'

RSpec.describe Setting do
  subject { described_class }

  its(:title) { is_expected.to eq 'DiverCoin' }
end
