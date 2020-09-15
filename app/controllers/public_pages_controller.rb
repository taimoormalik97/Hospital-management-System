class PublicPagesController < ApplicationController

  # GET /resource/index
  def index

  end

  # GET /resource/find
  def find
    @admin = Admin.new
  end

  # POST/resource/check_email
  def check_email
    @admin = email_in_params
    if Admin.unscoped.where(email: @admin[:email]).count(:hospital_id) == 1
      redirect_to new_user_session_url(email: @admin[:email], subdomain: Admin.unscoped.find_by_email(@admin[:email]).hospital.sub_domain)
    else
      redirect_to select_domain_url(email: @admin[:email])
    end
  end

  private

  def email_in_params
    params.require(:admin).permit(:email)
  end


end
