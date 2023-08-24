require 'rspec/rails/shared_contexts/action_cable'
require 'action_cable/testing/rspec/features'

RSpec.configure do |config|
  config.include ActionCable::TestHelper
end
