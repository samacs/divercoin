class CurrencyPolicy < ApplicationPolicy
  def index? = is_admin?
  def refresh? = is_admin?
  def active? = is_admin?
  def inactive? = is_admin?
  def import? = is_admin?
  def export? = user.present?

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
