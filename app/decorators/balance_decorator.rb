class BalanceDecorator < ApplicationDecorator
  def year_from_created(offset = 0) = Array.new(12) { |n| (created_at + offset.months) + n.months }
  # def yearly_profit(monthly_profit, offset = 0) = (amount * ((1 + 12 + offset)**(monthly_profit / 100))) - amount
end
