class FakeUser < ApplicationRecord
  include Sessionable
end

RSpec.describe Sessionable do
  switch_to_sqlite do
    create_table :fake_users do |t|
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.integer :sign_in_count, null: false, default: 0
    end
  end

  describe FakeUser do
    it_behaves_like 'sessionable'
  end
end
