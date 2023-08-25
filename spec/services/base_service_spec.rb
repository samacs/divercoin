require 'rails_helper'

RSpec.describe BaseService do
  subject(:result) { described_class.call(context) }

  context 'when base service is called' do
    let(:context) { {} }
    let(:expected_error) { 'Override the `.actions` method to provide the service actions.' }

    it { expect { result }.to raise_error(expected_error) }
  end
end
