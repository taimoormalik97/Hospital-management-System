class PublicPagesController < ApplicationController

  # GET /resource/index
  def index

  end

  # GET /resource/find
  def find
    @user = User.new
  end

  # POST/resource/check_email
  def check_email
    user = user_email_in_params
    if User.unscoped.where(email: user[:email]).count(:hospital_id) == 1
      redirect_to new_user_session_url(email: user[:email], subdomain: User.unscoped.find_by_email(user[:email]).hospital.sub_domain)
    else
      redirect_to select_domain_url(email: user[:email])
    end
  end

  private

  def user_email_in_params
    params.require(:user).permit(:email)
  end


end
