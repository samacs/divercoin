class CurrencyUpdaterWorker
  include Sidekiq::Worker

  def perform
    api_key = ENV.fetch('MESSARI_API_KEY', nil)
    api_url = ENV.fetch('MESSARI_API_V2_BASE_URL', nil)

    CurrencyUpdaterService.call(api_key:, api_url:)
  end
end
