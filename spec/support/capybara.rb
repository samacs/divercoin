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
    # Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    # Capybara.server_port = 4000

    Capybara::Selenium::Driver.new(app, browser: :remote, url: ENV['HUB_URL'], options:)
  else
    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  end
end

selenium_app_host = ENV.fetch('SELENIUM_APP_HOST') do
  Socket.ip_address_list
        .find(&:ipv4_private?)
        .ip_address
end

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.server_host = selenium_app_host
  config.server_port = 4000
end

RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    driver = :rack_test

    if example.metadata[:js]
      driver = :chrome_headless

      # Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:3000"
      Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
    end

    driven_by driver
  end
end
