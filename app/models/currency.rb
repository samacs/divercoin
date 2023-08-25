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
class Currency < ApplicationRecord
  enum :status, { active: 'active', inactive: 'inactive' }

  default_scope -> { in_order_of(:status, %w[active inactive]) }

  STATUS_SORT = {
    active: 1,
    inactive: 0
  }.freeze

  validates :name,
            :ticker,
            presence: true
  validates :ticker,
            uniqueness: { case_sensitive: false }

  def to_s = name

  def image(size = 64) = images[size] ||= "#{base_image_url}/#{asset_id}/#{size}.png"

  def status_sort
    STATUS_SORT[status]
  end

  private

  def base_image_url = ENV.fetch('MESSARI_IMAGES_BASE_URL')

  def images = @images ||= {}
end
