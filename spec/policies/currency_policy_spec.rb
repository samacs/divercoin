require 'rails_helper'

RSpec.describe CurrencyPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  permissions :index?, :refresh? do
    context 'when the user is not admin' do
      it { is_expected.not_to permit(user) }
    end
  end

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
