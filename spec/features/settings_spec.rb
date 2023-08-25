require 'rails_helper'

RSpec.describe 'Admin settings', type: :system do
  subject { page }

  describe 'GET /admin/settings' do
    context 'when the user is not signed in' do
      before { visit settings_path }

      it { is_expected.to have_current_path root_path }
      it { is_expected.to have_content(/user not signed in/i) }
    end
  end
end
