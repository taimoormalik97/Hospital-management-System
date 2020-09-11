class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.hospital = Hospital.first
    @doctor.save!
    if @doctor.valid?
      redirect_to doctors_path
      flash[:notice] = t('doctor.add.success')
    else
      flash[:error] = t('doctor.add.failure')
      redirect_to new_doctor_path
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doctor_params)
      flash[:notice] = t('doctor.udpate.success')
      redirect_to doctor_path(@doctor)
    else
      flash[:error] = t('doctor.udpate.failure')
      render edit_doctor_path(@doctor)
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    if @doctor.delete
      flash[:notice] = t('doctor.delete.success')
      redirect_to doctors_path
    else
      flash[:error] = t('doctor.delete.failure')
      render :destroy
    end
  end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :password, :registration_no, :speciality, :consultancy_fee)
  end
end
