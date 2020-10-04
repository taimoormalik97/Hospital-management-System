class HospitalController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'static_pages_layout', only: [:select_domain]
  before_action :page_breadcrumb, only: :search

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

  #GET /resource/search
  def search
    @medicines = Medicine.search(params[:search])
    @doctors = Doctor.search(params[:search])
    @patients = Patient.search(params[:search]) 
    respond_to do |format|
      format.html
    end
  end

  def page_breadcrumb
    add_breadcrumb t('search.breadcrumb'), search_path
  end
end
