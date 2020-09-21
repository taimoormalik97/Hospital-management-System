class AdminController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num

  before_action :root_page_breadcrumb, only: [:show, :edit]
  before_action :show_page_breadcrumb, only: [:show, :edit]

  # GET /resource/show
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /resource/edit
  def edit
    add_breadcrumb t('admin.breadcrumb.edit'), edit_admin_path
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

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('admin.breadcrumb.show'), admin_path
  end

end
