require 'rails_helper'

RSpec.describe Setting do
  subject { described_class }

  its(:title) { is_expected.to eq 'DiverCoin' }
end
