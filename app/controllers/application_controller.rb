class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :scope_current_hospital
  before_action :validate_subdomain, :redirect_to_valid_signup, :redirect_to_valid_signin, :redirect_to_valid_password_reset, :redirect_to_valid_confirmation_email, :devise_edit_profile

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", status: :not_found }
    end
  end

  rescue_from ActionController::RoutingError do
     respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", status: :not_found }
    end
  end

  add_flash_types :info, :error, :warning, :success

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

  def validate_subdomain
    render file: "#{Rails.root}/public/404", status: :not_found if (request.subdomain.present?) && (Hospital.find_by(sub_domain: request.subdomain).blank?)
  end
  def redirect_to_valid_signup
    redirect_to new_user_registration_url(subdomain: false) if (request.subdomain.present?) && (request.url.include? '/users/sign_up')
  end

  def redirect_to_valid_signin
    redirect_to find_path if (request.subdomain.blank?) && (request.url.include? '/users/sign_in')
  end

  def devise_edit_profile
    redirect_to root_path if request.url.include? '/users/edit'
  end

  def redirect_to_valid_password_reset
    unless request.subdomain.present?
      redirect_to find_path if (request.url.include? '/users/password/new') || (request.url.include? '/users/password/edit')
    end
  end

  def redirect_to_valid_confirmation_email
    unless request.subdomain.present?
      redirect_to find_path if (request.url.include? '/users/confirmation/new') || (request.url.include? '/users/confirmation')
    end
  end

end
