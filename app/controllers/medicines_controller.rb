class MedicinesController < ApplicationController

	include ActionController::MimeResponds
	load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

	def index
		@medicine = Medicine.all
	end

	def new
	end

	def show
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
			redirect_to medicines_path
		else
			flash[:notice] = t('medicine.search.success')		
			respond_to do |format|
				format.js{ render 'purchase_order/search' }
			end
		end
	end

	def create
		@medicine.hospital=current_hospital
		if @medicine.save   
			flash[:notice] = t('medicine.add.success')
			redirect_to medicine_path(@medicine)
		else   
			flash[:error] = t('medicine.add.failure')     
		end   
	end

	def edit
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

end
