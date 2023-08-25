class CurrencyDecorator < ApplicationDecorator
  def status_link
    case status
    when 'active' then h.link_to 'Disable', h.inactive_currency_path(object), data: { turbo_method: :patch }
    when 'inactive' then h.link_to 'Enable', h.active_currency_path(object), data: { turbo_method: :patch }
    end
  end
end
