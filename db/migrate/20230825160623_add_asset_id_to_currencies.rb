class AddAssetIdToCurrencies < ActiveRecord::Migration[7.0]
  def change
    add_column :currencies, :asset_id, :string
  end
end
