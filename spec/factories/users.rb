# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  email              :string(128)      not null
#  first_name         :string(128)      not null
#  last_name          :string(128)      not null
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  password_digest    :string(72)       not null
#  preferences        :jsonb            not null
#  sign_in_count      :integer          default(0), not null
#  slug               :string(255)      not null
#  terms_of_service   :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    terms_of_service { true }
  end
end
