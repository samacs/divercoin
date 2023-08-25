class StaticPagesController < ApplicationController
  skip_before_action :require_user

  before_action :render_not_found, unless: :page_exists?

  def show = render page_view

  private

  def page = @page ||= params[:page]

  def page_view = @page_view ||= [controller_name, page.underscore].join('/')

  def page_exists? = lookup_context.template_exists?(page_view, [], false)

  def render_not_found = render 'static_pages/not_found'
end
