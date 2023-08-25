module Currencies
  class UpdateMonthlyProfitFromCsvAction < BaseAction
    expects :csv

    executed do |ctx|
      coin_mapper = { 'Bitcoin' => 'btc', 'Ether' => 'eth', 'Cardano' => 'ada' }
      ctx.csv.each do |row|
        ticker = coin_mapper[row['Moneda']]
        monthly_profit = row['Interes_mensual']
        currency = Currency.find_by(ticker:)
        currency.update(monthly_profit:)
      end
    end
  end
end
