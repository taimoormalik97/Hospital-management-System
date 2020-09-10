class MedicinesController < ApplicationController
	include ActionController::MimeResponds
	def index
		@medicine = Medicine.all
	end
	def new
		@medicine = Medicine.new
	end
	def show
		@medicine = Medicine.find(params[:id])
	end
	def search
		#binding.pry
		response.content_type = Mime[:js]
		@medicine = Medicine.find_by(name: params[:search])
		if @medicine.blank?
			flash[:notice] = 'Medicine not found!'
			redirect_to root_path
		else		
			respond_to do |format|
        		format.js# { render partial: 'search-results', locals: @medicine}
      	    end
		end
	end
	def create
		@medicine = Medicine.new(medicine_params)
		@medicine.hospital=Hospital.first   
	    if @medicine.save   
	      flash[:notice] = 'Medicine successfully added!'   
	      redirect_to root_path   
	    else   
	      flash[:error] = 'Failed to add medicine'   
	      render :new   
	    end   
	end
	def edit
		@medicine= Medicine.find(params[:id])
	end
	def update
	  @medicine= Medicine.find(params[:id])   
	    if @medicine.update_attributes(medicine_params)   
	      flash[:notice] = 'Med updated!'   
	      redirect_to root_path   
	    else   
	      flash[:error] = 'Failed!'   
	      render :edit   
	    end   
	end
	def destroy
		@medicine = Medicine.find(params[:id])   
	    if @medicine.delete   
	      flash[:notice] = 'Medicine deleted!'   
	      redirect_to root_path   
	    else   
	      flash[:error] = 'Failed to delete!'   
	      render :destroy   
	    end   
	end
	def medicine_params   
    params.require(:medicine).permit(:name, :price, :quantity, :search)   
  end   
end
