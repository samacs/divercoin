# Helper methods to test ActiveRecord concerns in isolation with an in-memory database.
module InMemoryDatabaseHelper
  extend ActiveSupport::Concern

  class_methods do
    def switch_to_sqlite(&)
      before(:all) { switch_to_in_memory_database(&) }
      after(:all) { switch_back_to_test_database }
    end
  end

  private

  def switch_to_in_memory_database(&block)
    raise 'No migration given' unless block

    ActiveRecord::Migration.verbose = false
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    ActiveRecord::Schema.define(version: 1, &block)
  end

  def switch_back_to_test_database
    ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration['test'])
  end
end

RSpec.configure do |config|
  config.include InMemoryDatabaseHelper, type: :model
end
