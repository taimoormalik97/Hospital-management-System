class PrescribedMedicinesController < ApplicationController
  #before_action :load_prescription
  load_and_authorize_resource find_by: :sequence_num
  load_and_authorize_resource :prescription, find_by: :sequence_num

  # GET /prescribed_medicine/new
  def new
    respond_to do |format|
      @prescribed_medicine = PrescribedMedicine.new
      format.js { render 'prescriptions/new_medicine' }
    end
  end

  # POST /prescribed_medicines
  def create
    @prescribed_medicine.prescription = @prescription
    respond_to do |format|
      @prescribed_medicine.save
      format.js { render 'prescriptions/medicines_in_prescription' }
    end
  end

  # DELETE /prescribed_medicine/:id
  def destroy
    respond_to do |format|
      @prescribed_medicine.destroy
      format.js { render 'prescriptions/medicines_in_prescription' }
    end
  end

  private

  def prescribed_medicine_params
    params.require(:prescribed_medicine).permit(:medicine_id, :quantity, :usage_instruction)
  end

  def load_prescription
   # @prescription = Prescription.includes(prescribed_medicines: :medicine).find_by(sequence_num: params[:prescription_id])
  end

end