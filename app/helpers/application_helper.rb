module ApplicationHelper
  def title(base_title = 'DiverCoin', separator: ' | ')
    parts = [base_title]
    parts << content_for(:title) if content_for?(:title)
    parts.reverse!

    tag.title parts.join(separator)
  end

  def meta_viewport(content = 'width=device-width,initial-scale=1')
    tag.meta name: 'viewport', content:
  end

  def meta_charset(charset = 'utf-8')
    tag.meta charset:
  end

  def render_flash_messages = render_shared_partial('flash_messages')

  def render_form_errors(resource) = render_shared_partial('form_errors', resource:)

  def render_shared_partial(partial, **) = render("shared/#{partial}", **)

  def render_header_partial(partial, **) = render_layout_partial("header/#{partial}", **)

  def render_layout_partial(partial, **) = render("layouts/#{partial}", **)
end
