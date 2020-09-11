class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.hospital = Hospital.first
    @patient.save!
    if @patient.valid?
      flash[:notice] = t('patient.add.success')
      redirect_to patients_path
    else
      flash[:error] = t('patient.add.failure')
      redirect_to new_patient_path
    end
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      flash[:notice] = t('patient.udpate.success')
      redirect_to patient_path(@patient)
    else
      flash[:error] = t('patient.udpate.failure')
      render edit_patient_path(@patient)
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    if @patient.delete
      flash[:notice] = t('patient.delete.success')
      redirect_to patients_path
    else
      flash[:error] = t('patient.delete.failure')
      render :destroy
    end
  end

  def patient_params
    params.require(:patient).permit(:name, :email, :password, :gender, :dob, :family_history)
  end
end
