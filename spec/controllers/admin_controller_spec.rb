require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  context 'as an admin' do
    login_admin
    set_referer

    describe 'GET #index' do

      before(:each) do
        @enabled_users = []
        @disabled_users = []
        5.times { @enabled_users << create(:user) }
        5.times { @disabled_users << create(:user, :disabled) }
      end

      it 'assigns disabled users as @disabled_users' do
        get :index, {}, @session
        expect(assigns(:disabled_users)).to match_array(@disabled_users)
      end

      it 'assigns enabled users as @enabled_users' do
        get :index, {}, @session
        expect(assigns(:enabled_users)).to match_array([@current_user, @enabled_users].flatten)
      end

    end

    describe 'GET #enable_user' do
      it 'enables the account' do
        disabled_user = create(:user, :disabled)
        post :enable_user, {user_id: disabled_user.to_param}, @session
        disabled_user.reload
        expect(disabled_user.enabled).to eq(true)
      end
    end

  end # context 'as an admin'

  context 'as a user' do
    login_user
    set_referer

    describe 'GET #index' do
      it 'redirects to :back' do
        get :index, {}, @session
        expect(response).to redirect_to(:back)
      end
    end
    describe 'GET #enable_user' do
      it 'redirects to :back' do
        disabled_user = create(:user, :disabled)
        get :enable_user, {user_id: disabled_user.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end # context 'as a user'

end
