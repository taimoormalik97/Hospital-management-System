class PublicPagesController < ApplicationController
  layout 'static_pages_layout', only: [:about, :contact, :find]

  # GET /resource/index
  def index
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  # GET /resource/about
  def about
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/contact
  def contact
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/find
  def find
    @user = User.new
    respond_to do |format|
      format.html
    end
  end

  # POST/resource/check_email
  def check_email
    respond_to do |format|
      user = user_email_in_params
      if User.unscoped.where(email: user[:email]).count(:hospital_id) == 1
        format.html{ redirect_to new_user_session_url(email: user[:email], subdomain: User.unscoped.find_by_email(user[:email]).hospital.sub_domain) }
      elsif User.unscoped.where(email: user[:email]) == []
        flash[:error] = t('guest.find.error')
        format.html { redirect_to :find }
      else
        format.html { redirect_to select_domain_url(email: user[:email]) }
      end
    end
  end

  private

  def user_email_in_params
    params.require(:user).permit(:email)
  end

end
