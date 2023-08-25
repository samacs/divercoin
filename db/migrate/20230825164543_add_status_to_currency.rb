class AddStatusToCurrency < ActiveRecord::Migration[7.0]
  def change
    add_column :currencies, :status, :enum, enum_type: :currency_status, default: :inactive
  end
end
