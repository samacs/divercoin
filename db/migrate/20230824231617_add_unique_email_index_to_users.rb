class AddUniqueEmailIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
  end
end
