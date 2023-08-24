require 'rails_helper'

RSpec.describe 'Static pages', type: :system do
  subject { page }

  describe 'GET /' do
    before { visit root_path }

    it { is_expected.to have_http_status :ok }

    it 'uses JavaScript', js: true do
      click_button 'Default tooltip'

      expect(page).to have_content 'Tooltip content'
    end
  end
end
