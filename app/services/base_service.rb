class BaseService
  extend LightService::Organizer

  class << self
    def call(context)
      context = context.to_h if context.respond_to?(:to_h)
      context = context.deep_symbolize_keys if context.is_a?(Hash)
      context = LightService::Context.make(context)

      with(context).reduce(actions)
    end

    private

    def actions
      raise 'Override the `.actions` method to provide the service actions.'
    end
  end
end
