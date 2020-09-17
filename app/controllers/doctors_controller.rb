class DoctorsController < ApplicationController
  load_and_authorize_resource

  before_action :root_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]
  
  # GET /doctors
  def index
    @doctors = @doctors.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/new
  def new
    add_breadcrumb t('doctor.breadcrumb.new'), new_doctor_path
    respond_to do |format|
      format.html
    end
  end

  # POST /doctors
  def create
    respond_to do |format|
      if @doctor.save
        flash[:notice] = t('doctor.add.success')
        format.html { redirect_to doctors_path }
      else
        flash[:error] = t('doctor.add.failure')
        format.html { render :new }
      end
    end
  end

  # GET /doctors/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/:id/edit
  def edit
    add_breadcrumb t('doctor.breadcrumb.edit'), edit_doctor_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /doctors/:id
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        flash[:notice] = t('doctor.update.success')
        format.html { redirect_to doctor_path(@doctor) }
      else
        flash[:error] = t('doctor.update.failure')
        format.html { render :edit }
      end
    end
  end

  # DELETE  /doctors/:id
  def destroy
    @doctor.destroy
    respond_to do |format|
      if @doctor.destroyed?
        flash[:notice] = t('doctor.delete.success')
        format.html { redirect_to doctors_path }
      else
        flash[:error] = t('doctor.delete.failure')
        format.html { render :show }
      end
    end
  end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :password, :registration_no, :speciality, :consultancy_fee)
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('doctor.breadcrumb.index'), doctors_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('doctor.breadcrumb.show'), doctor_path
  end

end
