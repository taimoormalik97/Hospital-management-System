require 'date'
class AppointmentsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  before_action :root_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]
  helper_method :date_to_day

  # GET /appointments
  def index
    @appointments = @appointments.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  # GET /appointments/new
  def new
    add_breadcrumb t('appointment.breadcrumb.new'), new_appointment_path
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /appointments
  def create
    respond_to do |format|
      if @appointment.save
        flash[:notice] = t('appointment.add.success')
        format.html { redirect_to appointments_path }
      else
        flash[:error] = [t('appointment.add.failure')]
        flash[:error] += @appointment.errors.full_messages
        format.html { redirect_to appointments_path }
        format.js
      end
    end
  end

  # GET /appointments/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /appointments/:id/edit
  def edit
    add_breadcrumb t('appointment.breadcrumb.edit'), edit_appointment_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /appointments/:id
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        flash[:notice] = t('appointment.update.success')
        format.html { redirect_to appointment_path(@appointment) }
      else
        flash[:error] = [t('appointment.update.failure')]
        flash[:error] += @appointment.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  # DELETE  /appointments/:id
  def destroy
    @appointment.destroy
    respond_to do |format|
      if @appointment.destroyed?
        flash[:notice] = t('appointment.delete.success')
        format.html { redirect_to appointments_path }
      else
        flash[:error] = [t('appointment.delete.failure')]
        flash[:error] += @appointment.errors.full_messages
        format.html { render :show }
      end
    end
  end

  def appointment_params
    params.require(:appointment).permit(:date)
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('appointment.breadcrumb.index'), appointments_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('appointment.breadcrumb.show'), appointment_path
  end

  def date_to_day(date)
    if(!date.nil?)
      date.to_date.strftime("%A")
    end
  end

  def show_availabilities
    params[:date] = date_to_day(params[:date])
    respond_to do |format|
      format.js
    end
  end

end
