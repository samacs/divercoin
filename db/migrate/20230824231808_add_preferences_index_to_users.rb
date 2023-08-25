class AddPreferencesIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :preferences, using: :gin
  end
end
