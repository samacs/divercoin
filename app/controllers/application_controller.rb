class ApplicationController < ActionController::Base
  include SessionManagement
  include TurboManagement

  add_flash_types :success, :warning, :error
end
