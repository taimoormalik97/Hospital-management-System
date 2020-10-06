class PrescriptionsController < ApplicationController
  before_action :redirect_to_prescriptions
  before_action :load_prescription, only: :show
  before_action :load_prescriptions, only: :index
  before_action :index_page_breadcrumb, only: %i[index show edit]
  before_action :show_page_breadcrumb, only: %i[show edit]
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  # GET /prescriptions
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /prescription/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /prescription/new
  def new
    respond_to do |format|
      appointment = @current_hospital.appointments.find_by(sequence_num: params[:appointment_id])
      @prescription.appointment = appointment
      @prescription.save
      format.html { redirect_to prescription_path(@prescription) }
    end
  end

  # GET /prescription/:id/edit
  def edit
    add_breadcrumb t('prescription.breadcrumb.edit'), edit_prescription_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH /prescription/:id
  def update
    @check_updated = @prescription.update(prescription_params)
    respond_to do |format|
      if @check_updated
        flash[:notice] = t('prescription.update.success')
        format.html { redirect_to prescription_path(@prescription) }
      else
        flash[:error] = t('prescription.update.failure')
        format.html { render :edit }
      end
    end
  end

  # DELETE /prescription/:id
  def destroy
    @prescription.destroy
    respond_to do |format|
      if @prescription.destroyed?
        format.html { redirect_to prescriptions_path, notice: t('prescription.delete.success') }
      else
        flash[:error] = [t('prescription.delete.failure')]
        flash[:error] += @prescription.errors.full_messages if @prescription.errors.any?
        format.html { render :show }
      end
    end
  end

  # GET /prescription/search_medicine
  def search_medicine
    @medicines = Medicine.search_medicines(params[:q])
    respond_to do |format|
      format.json { render json: @medicines }
    end
  end

  private

  def prescription_params
    params.require(:prescription).permit(:notes)
  end

  def load_prescription
    @prescription = Prescription.includes(prescribed_medicines: :medicine).find_by(sequence_num: params[:appointment_id])
  end

  def load_prescriptions
    @prescriptions = Prescription.includes(appointment: [:doctor, :patient, :availability]).available_prescriptions(@current_user).load
  end

  def index_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.index'), prescriptions_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.show'), prescription_path
  end

  def redirect_to_prescriptions
    redirect_to prescriptions_path if request.subdomain.present? && user_signed_in? && request.path == '/prescriptions/new' && params[:appointment_id].nil?
  end
end
