module TurboManagement
  extend ActiveSupport::Concern

  included do
    helper_method :form_id, :generate_form_id
  end

  protected

  def turbo_replace_form(partial: 'form', **locals) = turbo_stream.replace(form_id, partial:, locals:)

  def form_id = @form_id ||= params[:form_id] || generate_form_id

  def generate_form_id(**options)
    [options[:prefix],
     options[:resource] || SecureRandom.uuid,
     options[:suffix]].compact.join(options[:separator] || '-')
  end
end
