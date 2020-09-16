class PublicPagesController < ApplicationController
  layout false

  # GET /resource/index
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/find
  def find
    @admin = Admin.new
    respond_to do |format|
      format.html
    end
  end

  # POST/resource/check_email
  def check_email
    @admin = email_in_params
    respond_to do |format|
      if Admin.unscoped.where(email: @admin[:email]).count(:hospital_id) == 1
        format.html { redirect_to new_user_session_url(email: @admin[:email], subdomain: Admin.unscoped.find_by_email(@admin[:email]).hospital.sub_domain) }
      else
        format.html { redirect_to select_domain_url(email: @admin[:email]) }
      end
    end
  end

  private

  def email_in_params
    params.require(:admin).permit(:email)
  end


end
