class CurrenciesController < ApplicationController
  before_action :authorize!

  expose :currencies, -> { Currency.all.map(&:decorate) }
  expose :currency, decorate: ->(currency) { CurrencyDecorator.new(currency) }

  def active
    currency.active!

    render turbo_stream: [turbo_stream.replace(helpers.dom_id(currency),
                                               partial: 'currencies/table_row',
                                               locals: { currency: })]
  end

  def inactive
    currency.inactive!

    render turbo_stream: [turbo_stream.replace(helpers.dom_id(currency),
                                               partial: 'currencies/table_row',
                                               locals: { currency: })]
  end

  def import
    file = import_params[:file]
    result = UploaderService.call(file:)

    CurrencyMontlyProfitUpdater.perform_async(result.filepath.to_s)

    render turbo_stream: turbo_replace_flash("File #{result.filename} is being processed", :success)
  rescue StandardError => e
    render turbo_stream: turbo_replace_flash(e.message, :error)
  end

  def export
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{controller_name}.csv"
      end
      format.json do
        response.headers['Content-Type'] = 'application/json; charset=utf-8'
        response.headers['Content-Disposition'] = "attachment; filename=#{controller_name}.json"
      end
    end
  end

  def refresh; end

  private

  def import_params
    params.permit(:file)
  end

  def authorize! = authorize Currency
end
