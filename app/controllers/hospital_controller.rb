class HospitalController < ApplicationController
  layout 'static_pages_layout', only: [:select_domain]

  # GET /resource/index
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/select_domain
  def select_domain
    @selected_users = User.unscoped.all.where(email: params[:email]).includes(:hospital)
    respond_to do |format|
      format.html
    end
  end

end
