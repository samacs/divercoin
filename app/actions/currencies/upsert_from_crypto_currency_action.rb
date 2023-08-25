module Currencies
  class UpsertFromCryptoCurrencyAction < BaseAction
    expects :response

    promises :currency

    executed do |ctx|
      ctx.currency = Currency.find_or_create_by(ticker: ctx.response[:symbol].downcase) do |currency|
        currency.asset_id = ctx.response[:id]
        currency.name = ctx.response[:name]
        currency.price = ctx.response[:metrics][:market_data][:price_usd]

        logger.debug "Creating currency for #{ctx.response[:name]}"
      end
      new_price = ctx.response[:metrics][:market_data][:price_usd]
      if ctx.currency.price != new_price
        logger.debug "Updating price for #{ctx.currency.name}"
        ctx.currency.update(price: new_price)
      end
    end
  end
end
