RSpec.configure do |config|
  config.include AbstractController::Translation

  config.extend AbstractController::Translation
end
