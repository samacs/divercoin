class CurrencyMonthlyProfitUpdaterService < BaseService
  class << self
    def actions
      [
        Currencies::ReadCsvFileAction,
        Currencies::UpdateMonthlyProfitFromCsvAction
      ]
    end
  end
end
