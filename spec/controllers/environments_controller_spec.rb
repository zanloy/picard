require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Server. As you add validations to Server, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Production',
      domain: 'vbms.vba.va.gov',
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      invalid: true,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ServersController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: 1 } }

  describe "GET #index" do
    it "assigns all environments as @environments" do
      environment = Environment.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:environments)).to eq([environment])
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
