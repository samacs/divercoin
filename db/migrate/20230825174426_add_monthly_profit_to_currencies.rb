class AddMonthlyProfitToCurrencies < ActiveRecord::Migration[7.0]
  def change
    add_column :currencies, :monthly_profit, :decimal, precision: 8, scale: 2, null: false, default: 0.0
  end
end
