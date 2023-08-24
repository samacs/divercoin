RSpec.shared_examples_for 'static page' do
  before { visit current_path }

  it { is_expected.to have_http_status :ok }
  it { is_expected.to have_current_path current_path }
  it { is_expected.to have_css "a[href=\"#{current_path}\"][aria-current=\"page\"]" }
end
