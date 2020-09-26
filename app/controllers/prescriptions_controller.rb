class PrescriptionsController < ApplicationController
  before_action :load_prescription, only: :show
  before_action :load_prescriptions, only: :index
  before_action :index_page_breadcrumb, only: [:index, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]
  load_and_authorize_resource find_by: :sequence_num

  def index
    respond_to do |format|
      format.html
    end
  end

   def show  
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      @prescription.appointment = Appointment.find_by(sequence_num: params[:id])
      @prescription.save
      format.html { render :show }
    end
  end

  def edit
    add_breadcrumb t('prescription.breadcrumb.edit'), edit_prescription_path
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        flash[:notice] = t('prescription.update.success')
        format.html { redirect_to prescription_path(@prescription) }
      else
        flash[:error] = t('prescription.update.failure')
        format.html { render :edit }
      end
    end
  end

  def search_medicine
    @medicines = Medicine.search(params[:q])
    respond_to do |format|
      format.json { render json: @medicines }
    end
  end

  private

  def prescription_params
    params.require(:prescription).permit(:notes)
  end

  def load_prescription
    @prescription = Prescription.includes(prescribed_medicines: :medicine).find_by(sequence_num: params[:id])
  end

  def load_prescriptions
    @prescriptions = Prescription.includes(appointment: [:doctor, :patient, :availability]).all
  end

  def index_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.index'), prescriptions_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.show'), prescription_path
  end

end
