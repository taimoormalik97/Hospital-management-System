class AvailabilitiesController < ApplicationController
  load_and_authorize_resource :doctor, find_by: :sequence_num
  load_and_authorize_resource :availability, through: :doctor, find_by: :sequence_num

  before_action :index_page_breadcrumb, only: %i[index new]

  # GET /availabilities
  def index
    respond_to do |format|
      @selected_week_day = params[:week_day] || Availability::DEFAULT_WEEK_DAY
      @availabilities = @availabilities.slots_for_a_day(@selected_week_day)
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
    if @availability.breakslots
      flash[:notice] = t('availability.add.success')
    else
      flash[:error] = [t('availability.add.failure')]
      flash[:error] += @availability.errors.full_messages.first(5) if @availability.errors.any?
    end
    respond_to do |format|
      format.html { redirect_to doctor_availabilities_path(@doctor, week_day: params[:availability][:week_day]) }
    end
  end


  # DELETE  /availabilities/:id
  def destroy
    if @availability.destroy
      flash[:notice] = t('availability.delete.success')
    else
      flash[:error] = [t('availability.delete.failure')]
      flash[:error] += @availability.errors.full_messages.first(5) if @availability.errors.any?
    end
    respond_to do |format|
      format.html { redirect_to doctor_availabilities_path(@doctor, week_day: @availability.week_day) }
    end
  end

  def availability_params
    params.require(:availability).permit(:start_slot, :end_slot, :week_day)
  end
  
  def index_page_breadcrumb
    add_breadcrumb t('availability.breadcrumb'), doctor_availabilities_path(@doctor)
  end
end
