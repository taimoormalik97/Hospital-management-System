class AvailabilitiesController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  before_action :root_page_breadcrumb, only: [:index, :new]
  before_action :index_page_breadcrumb, only: [:index, :new]

  # GET /availabilities
  def index
    @availabilities = @availabilities.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  # GET /availabilities/new
  def new
    add_breadcrumb t('availability.breadcrumb'), new_availability_path
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /availabilities
  def create
    respond_to do |format|
      if invalid_slot? 
        flash[:error] += [t('availability.add.failure')]
        flash[:error] += @availability.errors.full_messages
        format.html { redirect_to availabilities_path }
        format.js
      elsif breakslots
        flash[:notice] = t('availability.add.success')
        format.html { redirect_to availabilities_path }
      else
        flash[:error] = [t('availability.add.failure')]
        flash[:error] += @availability.errors.full_messages
        format.html { redirect_to availabilities_path }
        format.js
      end
    end
  end

  # DELETE  /availabilities/:id
  def destroy
    @availability.destroy
    respond_to do |format|
      if @availability.destroyed?
        flash[:notice] = t('availability.delete.success')
        format.html { redirect_to availabilities_path }
      else
        flash[:error] = [t('availability.delete.failure')]
        flash[:error] += @availability.errors.full_messages
        format.html { render :show }
      end
    end
  end

  def availability_params
    params.require(:availability).permit(:start_slot, :end_slot, :week_day)
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('availability.breadcrumb'), availabilities_path
  end

  def invalid_slot?
    starting = ((@availability.start_slot)+1.minute).strftime("%H%M")
    ending = ((@availability.end_slot)-1.minute).strftime("%H%M")
    if starting >= ending
      flash[:error] = ['End should be greater then Start!']
      return true
    end
    all_availability = current_user.availabilities.where(week_day: @availability.week_day)
    all_availability.each do |event|
      if starting.between?(event.start_slot.strftime("%H%M"), event.end_slot.strftime("%H%M")) || ending.between?(event.start_slot.strftime("%H%M"), event.end_slot.strftime("%H%M"))
        flash[:error] = ['Current Slot Time is already taken!']
        return true
      end
    end
    return false
  end

  def breakslots
    weekday = @availability.week_day
    doctor = @availability.doctor_id
    check_end = @availability.end_slot
    starting = @availability.start_slot
    ending = @availability.start_slot+30.minute
    @availability.end_slot = @availability.start_slot+30.minute
    until ending > check_end 
      if !@availability.save
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
