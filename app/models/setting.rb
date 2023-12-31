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
class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  field :title, type: :string, default: 'DiverCoin', validates: { presence: true }
  field :messari_api_key, type: :string, default: ENV.fetch('MESSARI_API_KEY', '')
end
