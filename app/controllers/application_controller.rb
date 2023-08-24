class ApplicationController < ActionController::Base
  include TurboManagement

  add_flash_types :success, :warning, :error
end
