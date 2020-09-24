class AvailabilitiesController < ApplicationController
  load_and_authorize_resource :doctor, find_by: :sequence_num
  load_and_authorize_resource :availability, through: :doctor, find_by: :sequence_num

  before_action :index_page_breadcrumb, only: [:index, :new]

  # GET /availabilities
  def index
    @availabilities = @availabilities.paginate(page: params[:page], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET /availabilities/new
  def new
    add_breadcrumb t('availability.breadcrumb'), new_doctor_availability_path(@doctor)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /availabilities
  def create
    respond_to do |format|
      if @availability.save
        format.html { redirect_to doctor_availabilities_path(@doctor), notice: t('availability.add.success') }
      else
        flash[:error] = [t('availability.add.failure')]
        flash[:error] += @availability.errors.full_messages.first(5) if @availability.errors.any?
        format.html { redirect_to doctor_availabilities_path }
        format.js
      end
    end
  end

  # DELETE  /availabilities/:id
  def destroy
    @availability.destroy
    respond_to do |format|
      if @availability.destroyed?
        format.html { redirect_to doctor_availabilities_path(@doctor), notice: t('availability.delete.success') }
      else
        flash[:error] = [t('availability.delete.failure')]
        flash[:error] += @availability.errors.full_messages.first(5) if @availability.errors.any?
        format.html { render :show }
      end
    end
  end

  def availability_params
    params.require(:availability).permit(:start_slot, :end_slot, :week_day)
  end
  
  def index_page_breadcrumb
    add_breadcrumb t('availability.breadcrumb'), doctor_availabilities_path(@doctor)
  end

  def breakslots
    weekday = @availability.week_day
    doctor = @availability.doctor_id
    check_end = @availability.end_slot
    starting = @availability.start_slot
    ending = @availability.start_slot+30.minute
    @availability.end_slot = @availability.start_slot+30.minute
    until ending > check_end 
      unless @availability.save
        return false
      end
      @availability = Availability.new
      @availability.week_day = weekday
      @availability.doctor_id= doctor
      starting = ending
      ending = starting+30.minute
      @availability.start_slot = starting
      @availability.end_slot = ending
    end
    return true
  end
end
