require 'csv'

module Currencies
  class ReadCsvFileAction < BaseAction
    expects :filepath

    promises :csv

    executed do |ctx|
      ctx.csv = CSV.parse(File.read(ctx.filepath), headers: true)
    end
  end
end
