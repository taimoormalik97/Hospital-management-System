class AdminController < ApplicationController
  load_and_authorize_resource

  # GET /resource/show
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/resource/update
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        flash[:notice] = t('admin.update.success')
        format.html { redirect_to @admin }
      else
        flash[:error] = t('admin.update.failure')
        format.html { render :edit }
      end
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end

end
