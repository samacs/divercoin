class SignUpService < BaseService
  class << self
    def actions
      [
        Users::CreateUserAction
      ]
    end
  end
end
