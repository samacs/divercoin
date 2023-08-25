class SettingsController < ApplicationController
  before_action :authorize!
  before_action :validate_settings, only: :update

  def update
    return render :edit if @errors.any?

    settings_params.each_key do |key|
      Setting.send("#{key}=", settings_params[key].strip) unless settings_params[key].nil?
    end

    redirect_to settings_path, success: 'Settings saved'
  end

  private

  def validate_settings
    @errors = ActiveModel::Errors.new(Setting.new)

    settings_params.each_key do |key|
      next if settings_params[key].nil?

      setting = Setting.new(var: key)
      setting.value = settings_params[key].strip
      @errors.merge!(setting.errors) unless setting.valid?
    end
  end

  def settings_params
    params.require(:settings).permit(:title, :messari_api_key)
  end

  def authorize! = authorize Setting
end
