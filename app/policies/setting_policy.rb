class SettingPolicy < ApplicationPolicy
  def edit? = is_admin?
  def update? = is_admin?
end
