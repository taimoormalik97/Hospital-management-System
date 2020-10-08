class MedicinesController < ApplicationController

  include ActionController::MimeResponds
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  before_action :index_page_breadcrumb, only: %i[index new show edit]
  before_action :show_page_breadcrumb, only: [:show]

  # GET /medicines
  def index
    @medicines = @medicines.paginate(page: params[:page], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET /medicines/new
  def new
    add_breadcrumb t('medicine.breadcrumb.new'), new_medicine_path
    respond_to do |format|
      format.html
    end
  end

  # GET /medicines/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /medicines/search_medicines
  def search_medicines
    @medicines = current_hospital.medicines.where('quantity > 0').search_medicines(params[:q])
    respond_to do |format|
      format.json { render json: @medicines }
    end
  end

  # POST /medicines
  def create
    if @medicine.save
      flash[:notice] = t('medicine.add.success')
      redirect_to medicine_path(@medicine)
    else
      flash[:error] = [t('medicine.add.failure')]
      flash[:error] += @medicine.errors.full_messages if @medicine.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # GET /medicines/:id/edit
  def edit
    add_breadcrumb t('medicine.breadcrumb.edit'), edit_medicine_path
    respond_to do |format|
      format.html
    end
  end

  # PATCH /medicines/:id
  def update
    if @medicine.update_attributes(medicine_params)
      flash[:notice] = t('medicine.update.success')
      redirect_to @medicine
    else
      flash[:error] = [t('medicine.update.failure')]
      flash[:error] += @medicine.errors.full_messages if @medicine.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # DELETE /medicines/:id
  def destroy
    if @medicine.destroy
      flash[:notice] = t('medicine.delete.success')
      redirect_to medicines_path
    else
      flash[:error] = [t('medicine.delete.failure')]
      flash[:error] += @medicine.errors.full_messages if @medicine.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  def medicine_params
    params.require(:medicine).permit(:name, :price, :quantity, :search)
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('medicine.breadcrumb.index'), medicines_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('medicine.breadcrumb.show'), medicine_path
  end
end
