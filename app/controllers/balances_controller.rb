class BalancesController < ApplicationController
  expose :currencies, -> { Currency.active.map(&:decorate) }
  expose :balances, -> { current_user.balances.newer.map(&:decorate) }

  def index
    # noop
  end

  def create
    # TODO: Calculate initial balance with the cached currency values
    balance = current_user.balances.new(balance_params)
    return redirect_to portfolio_path, success: t('.success', balance:, amount: balance.amount) if balance.save

    render turbo_stream: turbo_replace_form(balance:)
  end

  private

  def balance_params = params.require(:balance).permit(:reference, :amount)
end
