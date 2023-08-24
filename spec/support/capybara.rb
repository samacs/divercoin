require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.register_driver(:chrome_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  %w[
    --no-sandbox
    --headless
    --disable-gpu
    --window-size=1400,1400
  ].each { |argument| options.add_argument(argument) }

  if ENV.fetch('HUB_URL')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: ENV['HUB_URL'], options:)
  else
    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  end
end

Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:4000"
Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
Capybara.server_port = 4000

RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    driver = :rack_test
    driver = :chrome_headless if example.metadata[:js]

    driven_by driver
  end
end
