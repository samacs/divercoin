class CreateCurrencyStatusEnum < ActiveRecord::Migration[7.0]
  def up
    create_enum :currency_status, %w[active inactive]
  end

  def down
    execute <<-SQL.squish
      DROP TYPE currency_status;
    SQL
  end
end
