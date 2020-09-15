class AdminController < ApplicationController
  load_and_authorize_resource

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
      else
        format.html { render :edit }
      end
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end

end