class BaseAction
  extend LightService::Action

  class << self
    def logger = Rails.logger
  end
end
