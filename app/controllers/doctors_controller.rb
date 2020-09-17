class DoctorsController < ApplicationController
  load_and_authorize_resource
  
  # GET /doctors
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/new
  def new
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

end
