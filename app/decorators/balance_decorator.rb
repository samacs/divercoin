class BalanceDecorator < ApplicationDecorator
  def year_from_created = Array.new(12) { |n| created_at + n.months }
end
