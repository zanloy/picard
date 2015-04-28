require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:valid_session) { { user_id: 1} }

  before(:all) do
    @user = User.create!({name: 'Test User', email: 'test@test.com', new_password: 'test'})
  end

  describe "GET #disabled" do
    it "renders the disabled page for disabled user" do
      user = User.create!({name: 'Test User', email: 'test@test.com', new_password: 'test'})
      get :disabled, {}, { user_id: @user.id }
      expect(response).to have_http_status(:success)
    end
    it "redirects to the home page for enabled user" do
      @user.update_attributes!({enabled: true})
      get :disabled, {}, { user_id: @user.id }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "POST #login_attempt" do
    before(:all) { @user.update_attributes!({enabled: true}) }
    it 'logs in successfully' do
      get :login_attempt, { email: 'test@test.com', password: 'test' }
      expect(response).to redirect_to(root_url)
    end
    it 'renders login page on failed password' do
      get :login_attempt, { email: 'test@test.com', password: 'bad_password' }
      expect(response).to redirect_to(signin_path)
    end
    it 'redirects to session[:last_path]' do
      get :login_attempt, { email: 'test@test.com', password: 'test' }, { last_path: '/test' }
      expect(response).to redirect_to('/test')
    end
  end

  describe "GET #destroy" do
    it 'erases the session' do
      delete :destroy, {}, { user_id: 1 }
      expect(session).to be_empty
    end
    it 'redirects to the root_url' do
      delete :destroy, {}, { user_id: 1 }
      expect(response).to redirect_to(root_url)
    end
  end

end
