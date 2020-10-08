require 'date'
class AppointmentsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  before_action :index_page_breadcrumb, only: %i[index new show edit]
  before_action :show_page_breadcrumb, only: %i[show edit]

  # GET /appointments
  def index
    @appointments = @appointments.includes(:doctor, :patient, :availability)
    @appointments = @appointments.paginate(page: params[:page], per_page: PAGINATION_SIZE)
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
        format.html { redirect_to appointments_path, notice: t('appointment.add.success') }
      else
        flash[:error] = [t('appointment.add.failure')]
        flash[:error] += @appointment.errors.full_messages if @appointment.errors.any?
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

  # PATCH /appointments/:id
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_path(@appointment), notice: t('appointment.update.success') }
      else
        flash[:error] = [t('appointment.update.failure')]
        flash[:error] += @appointment.errors.full_messages if @appointment.errors.any?
        format.html { render :edit }
      end
    end
  end

  def appointment_params
    params.require(:appointment).permit(:date, :doctor_id, :availability_id)
  end

  def index_page_breadcrumb
    add_breadcrumb t('appointment.breadcrumb.index'), appointments_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('appointment.breadcrumb.show'), appointment_path
  end

  # GET /show_availabilities
  def show_availabilities
    params[:date] = params[:date].to_date.strftime('%A') if params[:date].present?
    respond_to do |format|
      format.js
    end
  end

  # PUT /appointments/:id/approve
  def approve
    if @appointment.approve!
      flash[:notice] = t('appointment.approve.success')
    else
      flash[:error] = [t('appointment.approve.failure')]
      flash[:error] += @appointment.errors.full_messages if @appointment.errors.any?
    end
    respond_to do |format|
      format.html { redirect_to appointments_path }
    end
  end

  # PUT /appointments/:id/complete
  def complete
    if @appointment.complete!
      flash[:notice] = t('appointment.complete.success')
    else
      flash[:error] = [t('appointment.complete.failure')]
      flash[:error] += @appointment.errors.full_messages if @appointment.errors.any?
    end
    respond_to do |format|
      format.html { redirect_to appointments_path }
    end
  end

  # PUT /appointments/:id/complete
  def cancel
    if @appointment.cancel!
      flash[:notice] = t('appointment.cancel.success')
    else
      flash[:error] = [t('appointment.cancel.failure')]
      flash[:error] += @appointment.errors.full_messages if @appointment.errors.any?
    end
    respond_to do |format|
      format.html { redirect_to appointments_path }
    end
  end
end
