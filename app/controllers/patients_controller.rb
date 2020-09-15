class PatientsController < ApplicationController
  load_and_authorize_resource # find by sequence no.
  
  # GET /patients
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET  /patients/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # POST /patients
  def create
    respond_to do |format|
      if @patient.save
        flash[:notice] = t('patient.add.success')
        format.html { redirect_to patients_path }
      else
        flash[:error] = t('patient.add.failure')
        format.html { render :new }
      end
    end
  end

  # GET  /patients/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET  /patients/:id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT  /patients/:id
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        flash[:notice] = t('patient.update.success')
        format.html { redirect_to patient_path(@patient) }
      else
        flash[:error] = t('patient.update.failure')
        format.html { render :edit }
      end
    end
  end

  # DELETE /patients/:id
  def destroy
    @patient.destroy
    respond_to do |format|
      if @patient.destroyed?
        flash[:notice] = t('patient.delete.success')
        format.html { redirect_to patients_path }
      else
        flash[:error] = t('patient.delete.failure')
        format.html { render :show }
      end
    end
  end

  def patient_params
    params.require(:patient).permit(:name, :email, :password, :gender, :dob, :family_history)
  end
end
