class DoctorsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]
  
  # GET /doctors
  def index
    @doctors = @doctors.paginate(page: params[:page], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/new
  def new
    add_breadcrumb t('doctor.breadcrumb.new'), new_doctor_path
    respond_to do |format|
      format.html
    end
  end

  def search_pred
    @doctors = current_hospital.doctors.search(params[:q])
    respond_to do |format| 
      format.json { render json: @doctors }
    end
  end

  def search
    @doctor = current_hospital.doctors.find_by(id: params[:search])
    if @doctor.blank?
      flash[:notice] = t('medicine.search.failure')
    else
      flash[:notice] = t('medicine.search.success')   
      respond_to do |format|
        format.js { render 'bills/searchdoc' }
      end
    end
  end

  # POST /doctors
  def create
    @doctor.password = Devise.friendly_token.first(8)
    respond_to do |format|
      if @doctor.save
        format.html { redirect_to doctors_path, notice: t('doctor.add.success') }
      else
        flash[:error] = [t('doctor.add.failure')]
        flash[:error] += @doctor.errors.full_messages.first(5) if @doctor.errors.any?
        format.html { render :new }
      end
    end
  end

  # GET /doctors/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /doctors/:id/edit
  def edit
    add_breadcrumb t('doctor.breadcrumb.edit'), edit_doctor_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /doctors/:id
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to doctor_path(@doctor), notice: t('doctor.update.success') }
      else
        flash[:error] = [t('doctor.update.failure')]
        flash[:error] += @doctor.errors.full_messages.first(5) if @doctor.errors.any?
        format.html { render :edit }
      end
    end
  end

  # DELETE  /doctors/:id
  def destroy
    @doctor.destroy
    respond_to do |format|
      if @doctor.destroyed?
        format.html { redirect_to doctors_path, notice: t('doctor.delete.success') }
      else
        flash[:error] = [t('doctor.delete.failure')]
        flash[:error] += @doctor.errors.full_messages.first(5) if @doctor.errors.any?
        format.html { render :show }
      end
    end
  end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :registration_no, :speciality, :consultancy_fee)
  end

  def index_page_breadcrumb
    add_breadcrumb t('doctor.breadcrumb.index'), doctors_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('doctor.breadcrumb.show'), doctor_path
  end

end
