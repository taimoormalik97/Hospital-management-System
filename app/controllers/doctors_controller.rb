class DoctorsController < ApplicationController

  before_action :doctor_index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :doctor_show_page_breadcrumb, only: [:show, :edit]
  before_action :doctor_new_page_breadcrumb, only: [:new]
  before_action :doctor_edit_page_breadcrumb, only: [:edit]

  # GET /doctors
  def index
    @doctors = Doctor.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
    respond_to do |format|
      format.html
    end
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.hospital = Hospital.first
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
    @doctor = Doctor.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/:id/edit
  def edit
    @doctor = Doctor.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /doctors/:id
  def update
    @doctor = Doctor.find(params[:id])
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
    @doctor = Doctor.find(params[:id])
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

  def doctor_index_page_breadcrumb
    add_breadcrumb 'Doctors', doctors_path
  end

  def doctor_show_page_breadcrumb
    add_breadcrumb 'Doctor Detail', doctor_path
  end

  def doctor_new_page_breadcrumb
    add_breadcrumb 'New Doctor', new_doctor_path
  end

  def doctor_edit_page_breadcrumb
    add_breadcrumb 'Edit Doctor', edit_doctor_path
  end

end
