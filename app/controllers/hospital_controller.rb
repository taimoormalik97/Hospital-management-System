class HospitalController < ApplicationController

  # GET /resource/index
  def index
  end

  # GET /resource/select_domain
  def select_domain
    @admins = Admin.unscoped.all.where(email: params[:email])
  end

end
