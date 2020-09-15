class MedicinesController < ApplicationController

	include ActionController::MimeResponds

	def index
	  @medicine = Medicine.all
	end

	def new
	  @medicine = Medicine.new
	end

	def show
	  @medicine = Medicine.find_by(sequence_num: params[:id])
	end

	def search
	  @medicine = Medicine.find_by(name: params[:search])
	    if @medicine.blank?
		  flash[:notice] = t('medicine.search.failure')
		  redirect_to medicines_path
		else
		  flash[:notice] = t('medicine.search.success')		
		  respond_to do |format|
          format.js{ render 'purchase_order/search' }
      	  end
		end
	end

	def create

	  @medicine = Medicine.new(medicine_params)
	  #todo: fix this when PR is merged
	  @medicine.hospital=Hospital.first 
	    if @medicine.save   
	      flash[:notice] = t('medicine.create.success')
	      redirect_to medicine_path(@medicine)
	    else   
	      flash[:error] = t('medicine.create.failure')   
	      render :new   
	    end   
	end

	def edit
	  @medicine= Medicine.find_by(sequence_num: params[:id])
	end

	def update
	  @medicine= Medicine.find_by(sequence_num: params[:id])  
	    if @medicine.update_attributes(medicine_params)   
	      flash[:notice] = t('medicine.update.success')   
	      redirect_to @medicine
	    else   
	      flash[:error] = t('medicine.update.failure')     
	      render :edit   
	    end   
	end

	def destroy
	  @medicine = Medicine.find_by(sequence_num: params[:id]) 
	    if @medicine.delete   
	      flash[:notice] = t('medicine.delete.success')     
	      redirect_to medicines_path   
	    else   
	      flash[:error] = t('medicine.delete.failure')     
	      render :destroy   
	    end   
	end

    def medicine_params   
      params.require(:medicine).permit(:name, :price, :quantity, :search)   
    end  

end
