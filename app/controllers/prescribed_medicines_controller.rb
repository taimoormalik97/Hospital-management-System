class PrescribedMedicinesController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital
  load_and_authorize_resource :prescription, find_by: :sequence_num, through: :current_hospital

  # GET /prescriptions/:prescription_id/prescribed_medicine/new
  def new
    respond_to do |format|
      @prescribed_medicine = PrescribedMedicine.new
      format.js { render 'prescriptions/new_medicine' }
    end
  end

  # POST /prescriptions/:prescription_id/prescribed_medicine
  def create
    @prescribed_medicine.prescription = @prescription
    respond_to do |format|
      @prescribed_medicine.save
      format.js { render 'prescriptions/medicines_in_prescription' }
    end
  end

  # DELETE /prescriptions/:prescription_id/prescribed_medicine/:id
  def destroy
    @prescribed_medicine.destroy
    respond_to do |format|
      format.js { render 'prescriptions/medicines_in_prescription' }
    end
  end

  private

  def prescribed_medicine_params
    params.require(:prescribed_medicine).permit(:medicine_id, :quantity, :usage_instruction)
  end

end