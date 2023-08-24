require 'rspec/retry'

RSpec.configure do |config|
  config.verbose_retry = true
  config.display_try_failure_messages = true
  config.around :each, js: true do |example|
    example.run_with_retry retry: ENV.fetch('RSPEC_RETRY_COUNT', 3).to_i
  end
  config.retry_callback = proc do |example|
    Capybara.reset! if example.metadata[:js]
  end
end
