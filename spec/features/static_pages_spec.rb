require 'rails_helper'

RSpec.describe 'Static pages', type: :system do
  subject { page }

  %w[/ /company /marketplace].each do |expected_path|
    describe "GET #{expected_path}" do
      let(:current_path) { expected_path }

      it_behaves_like 'static page'
    end
  end

  describe '404 Not found' do
    before { visit '/not-existent-page' }

    it { is_expected.to have_http_status :ok }
    its(:text) { is_expected.to match(/not found/i) }
  end
end
