module IconHelper
  def icon(name, style: 'solid', **options)
    name = "fa-#{name}"
    style = "fa-#{style}"
    classes = (options.delete(:class) || '').split.append(name).append(style)

    tag.i class: classes.join(' '), **options
  end
end
