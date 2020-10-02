require 'rails_helper'
RSpec.describe AdminController, type: :controller do
  describe 'for admin' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @admin_params = FactoryGirl.attributes_for(:admin)
      @admin_params[:hospital] = @hospital
      @admin = User.create(@admin_params)
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @request.host = "#{@hospital.sub_domain}.localhost:3000"
      @admin.confirm
      sign_in @admin
    end

    after(:each) do
      sign_out @admin
    end

    ############# show #############
    describe 'GET show' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the :edit view' do
        get :show, params: { id: @admin.sequence_num }
        expect(response).to render_template :show
      end
    end

    ############# edit #############
    describe 'GET edit' do
      it 'renders the :edit view' do
        get :edit, params: { id: @admin.sequence_num }
        expect(response).to render_template :edit
      end
    end

    ############# update #############
    describe 'PATCH update' do
      it 'should return http success' do
        @admin_params[:name] = 'New Name'
        expect {
          patch :update, params: { id: @admin.sequence_num, admin: @admin_params}
        }.to_not change(@hospital.admins, :count)
      end

      it 'redirects to prescription show page' do
        @admin_params[:name] = 'New Name'
        patch :update, params: { id: @admin.sequence_num, admin: @admin_params }
        expect(response).to redirect_to admin_path(@hospital.admins.first)
      end
    end

  end
end
