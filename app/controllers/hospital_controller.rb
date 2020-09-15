class HospitalController < ApplicationController

  # GET /resource/index
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/select_domain
  def select_domain
    @admins = Admin.unscoped.all.where(email: params[:email])
    respond_to do |format|
      format.html
    end
  end

end
