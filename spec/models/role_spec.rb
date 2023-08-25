# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role do
  subject { user }

  let(:user) { create(:user) }

  it { is_expected.not_to have_role(:admin) }

  describe 'Admin role' do
    before { user.add_role(:admin) }

    it { is_expected.to have_role(:admin) }
  end
end
