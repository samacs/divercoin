module CryptoCurrencies
  class FetchCryptoCurrenciesAction < BaseAction
    expects :api_url, :api_key

    promises :response

    executed do |ctx|
      connection = Faraday.new(url: ctx.api_url, headers: { 'X-Messari-API-Key' => ctx.api_key })
      response = connection.get
      parsed_response = Oj.load(response.body)
      ctx.response = CryptoCurrencySerializer.many(parsed_response['data'].map(&:deep_symbolize_keys))
    end
  end
end
