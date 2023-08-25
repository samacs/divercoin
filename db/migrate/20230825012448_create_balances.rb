class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.string :reference, null: false
      t.string :slug, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false, default: 0.0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :balances, %i[user_id slug], unique: true
  end
end
