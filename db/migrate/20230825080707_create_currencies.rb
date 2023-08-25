class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :ticker, null: false
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.0

      t.timestamps
    end

    add_index :currencies, :ticker, unique: true
  end
end
