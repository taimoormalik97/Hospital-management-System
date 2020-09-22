class MedicinesController < ApplicationController
  
  include ActionController::MimeResponds
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital
  before_action :root_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show]

  def index
    @medicines = @medicines.paginate(page: params[:page], per_page: 5)
  end

  def new
    add_breadcrumb t('medicine.breadcrumb.new'), new_medicine_path
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def search_pred
    @medicines = Medicine.search(params[:q])
    respond_to do |format|
      format.html 
      format.json { render json: @medicines }
    end
  end

  def search
    @medicine = Medicine.find_by(id: params[:search])
    if @medicine.blank?
      flash[:notice] = t('medicine.search.failure')
    else
      flash[:notice] = t('medicine.search.success')   
      respond_to do |format|
        format.js{ render 'purchase_order/search' }
      end
    end
  end

  def create
    @medicine.hospital = current_hospital
    if @medicine.save   
      flash[:notice] = t('medicine.add.success')
      redirect_to medicine_path(@medicine)
    else   
      flash[:error] = t('medicine.add.failure')     
    end   
  end

  def edit
    add_breadcrumb t('medicine.breadcrumb.edit'), edit_medicine_path
    respond_to do |format|
      format.html
    end
  end

  def update  
    if @medicine.update_attributes(medicine_params)   
      flash[:notice] = t('medicine.update.success')   
      redirect_to @medicine
    else   
      flash[:error] = t('medicine.update.failure')       
    end   
  end

  def destroy
    if @medicine.destroy   
      flash[:notice] = t('medicine.delete.success')     
      redirect_to medicines_path   
    else   
      flash[:error] = t('medicine.delete.failure')       
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
