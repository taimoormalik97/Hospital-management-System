class PatientsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  before_action :index_page_breadcrumb, only: %i[index new show edit]
  before_action :show_page_breadcrumb, only: %i[show edit]

  # GET /patients
  def index
    @patients = @patients.paginate(page: params[:page], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET  /patients/new
  def new
    add_breadcrumb t('patient.breadcrumb.new'), new_patient_path
    respond_to do |format|
      format.html
    end
  end

  def search_pred
    @patients = current_hospital.patients.search_patients(params[:q])
    respond_to do |format|
      format.html
      format.json { render json: @patients }
    end
  end

  # POST /patients
  def create
    @patient.password = Devise.friendly_token.first(8)
    respond_to do |format|
      if @patient.save
        format.html { redirect_to patients_path, notice: t('patient.add.success') }
      else
        flash[:error] = [t('patient.add.failure')]
        flash[:error] += @patient.errors.full_messages.first(5) if @patient.errors.any?
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
    add_breadcrumb t('patient.breadcrumb.edit'), edit_patient_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT  /patients/:id
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_path(@patient), notice: t('patient.update.success') }
      else
        flash[:error] = [t('patient.update.failure')]
        flash[:error] += @patient.errors.full_messages.first(5) if @patient.errors.any?
        format.html { render :edit }
      end
    end
  end

  # DELETE /patients/:id
  def destroy
    @patient.destroy
    respond_to do |format|
      if @patient.destroyed?
        format.html { redirect_to patients_path, notice: t('patient.delete.success') }
      else
        flash[:error] = [t('patient.delete.failure')]
        flash[:error] += @patient.errors.full_messages.first(5) if @patient.errors.any?
        format.html { render :show }
      end
    end
  end

  def patient_params
    params.require(:patient).permit(:name, :email, :gender, :dob, :family_history)
  end

  def index_page_breadcrumb
    add_breadcrumb t('patient.breadcrumb.index'), patients_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('patient.breadcrumb.show'), patient_path
  end
end
