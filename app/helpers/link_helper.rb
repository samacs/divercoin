module LinkHelper
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    if block
      options ||= {}
      options[:class] = add_active_class(name, options)
      options['aria-current'] = 'page' if active_link?(name)
    else
      html_options ||= {}
      html_options[:class] = add_active_class(options, html_options)
      html_options['aria-current'] = 'page' if active_link?(options)
    end

    link_to(name, options, html_options, &block)
  end

  def active_link?(path) = request.path == path

  private

  def add_active_class(path, options)
    return options[:class] unless active_link?(path)

    options.fetch(:active_class, options[:class])
  end
end
