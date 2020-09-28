class PrescribedMedicinesController < ApplicationController
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

end