class AdminController < ApplicationController

  before_action :set_admin, only: [:show, :edit, :update]

  # GET /resource/show
  def show
  end

  # GET /resource/edit
  def edit
  end

  # PATCH/resource/update
  def update
    respond_to do |format|
         if @admin.update(admin_params)
            format.html { redirect_to @admin, notice: 'Profile was successfully updated.' }
            format.json { render :show, status: :ok, location: @admin }
         else
            format.html { render :edit }
            format.json { render json: @admin.errors, status: :unprocessable_entity }
         end
      end
  end

  private
   
  
   def set_admin
      @admin = Admin.find(params[:id])
   end

   def admin_params
      params.require(:admin).permit(:name, :email)
   end

end