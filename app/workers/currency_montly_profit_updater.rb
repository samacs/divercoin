require 'csv'

class CurrencyMontlyProfitUpdater
  include Sidekiq::Worker

  def perform(filepath)
    CurrencyMonthlyProfitUpdaterService.call(filepath:)
  end
end
