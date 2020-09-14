class ApplicationController < ActionController::Base

    # rescue_from ActionController::RoutingError do
    #   render file: "#{Rails.root}/public/404", status: :not_found
    # end

  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :scope_current_hospital
  before_action :check_valid_domain, :allow_signup_on_domain, :allow_signin_on_subdomain, :allow_password_reset_on_subdomain, :allow_confirmation_email_on_subdomain, :devise_edit_profile

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render plain: '4s04 Not Found', status: 404 }
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :type, hospital_attributes: [ :name, :sub_domain, :address, :phone_number ]])
  end

  def after_sign_in_path_for(resource)
     hospital_index_path
  end

  def after_sign_out_path_for(resource)
     new_user_session_path
  end
 
  def current_hospital
    Hospital.find_by(sub_domain: request.subdomain) if request.subdomain.present?
  end

  helper_method :current_hospital

  def scope_current_hospital
    Hospital.current_id = current_hospital.id if current_hospital.present?
    yield
  ensure
    Hospital.current_id = nil
  end

  def check_valid_domain
    if request.subdomain.present?
      if Hospital.find_by(sub_domain: request.subdomain).blank?
        render file: "#{Rails.root}/public/404", status: :not_found
      end
    end
  end
  def allow_signup_on_domain
    if request.subdomain.present?
      if request.url.include? '/users/sign_up'
        redirect_to new_user_registration_url(subdomain: false)
      end
    end
  end

  def allow_signin_on_subdomain
    unless request.subdomain.present?
      if request.url.include? '/users/sign_in'
        redirect_to find_path
      end
    end
  end

  def devise_edit_profile
    if request.url.include? '/users/edit'
      redirect_to root_path
    end
  end

  def allow_password_reset_on_subdomain
    unless request.subdomain.present?
      if request.url.include? '/users/password/new' or request.url.include? '/users/password/edit'
        redirect_to find_path
      end
    end
  end

  def allow_confirmation_email_on_subdomain
    unless request.subdomain.present?
      if request.url.include? '/users/confirmation/new' or request.url.include? '/users/confirmation'
        redirect_to find_path
      end
    end
  end

end
