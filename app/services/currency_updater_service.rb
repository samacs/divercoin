class CurrencyUpdaterService < BaseService
  class << self
    def actions
      [
        CryptoCurrencies::FetchCryptoCurrenciesAction,
        iterate(:response, [Currencies::UpsertFromCryptoCurrencyAction])
      ]
    end
  end
end
