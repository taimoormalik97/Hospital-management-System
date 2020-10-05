class DashboardsController < ApplicationController
  before_action :page_breadcrumb, only: :dashboard
  def dashboard
    respond_to do |format|
      format.html
    end
  end

  def page_breadcrumb
    add_breadcrumb t('dashboard.breadcrumb'), root_path
  end
end
