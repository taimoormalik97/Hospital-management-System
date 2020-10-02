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
      if @availability.breakslots
        flash[:notice] = t('availability.add.success')
        format.html { redirect_to doctor_availabilities_path(@doctor, week_day: params[:availability][:week_day]) }
      else
        flash[:error] = [t('availability.add.failure')]
        flash[:error] += @availability.errors.full_messages.first(5) if @availability.errors.any?
        format.html { redirect_to doctor_availabilities_path(@doctor, week_day: params[:availability][:week_day]) }
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
end
