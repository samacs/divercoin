class BaseContract
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
end
