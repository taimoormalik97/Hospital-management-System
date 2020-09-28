class PrescriptionsController < ApplicationController
  helper_method :get_prescriptions
  before_action :load_prescription, only: :show
  before_action :load_prescriptions, only: :index
  before_action :index_page_breadcrumb, only: [:index, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]
  load_and_authorize_resource find_by: :sequence_num

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
      appointment = Appointment.find_by(sequence_num: params[:id])
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

  # PATCH/PUT /prescription/:id
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

  # DELETE  /prescription/:id
  def destroy
    @prescription.destroy
    respond_to do |format|
      if @prescription.destroyed?
        format.html { redirect_to prescriptions_path, notice: t('prescription.delete.success') }
      else
        flash[:error] = [t('prescription.delete.failure')]
        flash[:error] += @prescription.errors.full_messages.first(5) if @prescription.errors.any?
        format.html { render :show }
      end
    end
  end

  # GET /prescription/search_medicine
  def search_medicine
    @medicines = Medicine.search(params[:q])
    respond_to do |format|
      format.json { render json: @medicines }
    end
  end

  def get_prescriptions
    if @current_user.doctor?
      @prescriptions.where(appointments: {doctor_id: @current_user.id})
    elsif @current_user.patient?
      @prescriptions.where(appointments: {patient_id: @current_user.id})
    else
      @prescriptions
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
    #@prescriptions = Prescription.accessible_by(current_ability, :read).all
    @prescriptions = Prescription.includes(appointment: [:doctor, :patient, :availability]).all
  end

  def index_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.index'), prescriptions_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('prescription.breadcrumb.show'), prescription_path
  end

end
