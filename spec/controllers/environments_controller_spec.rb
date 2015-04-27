require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # environment. As you add validations to environment, be sure to
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
  # environmentsController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: 1 } }

  describe "GET #index" do
    it "assigns all environments as @environments" do
      environment = Environment.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:environments)).to eq([environment])
    end
  end

  describe "GET #show" do
    it "assigns the requested environment as @environment" do
      environment = Environment.create! valid_attributes
      get :show, {:id => environment.to_param}, valid_session
      expect(assigns(:environment)).to eq(environment)
    end
  end

  describe "GET #new" do
    it "assigns a new environment as @environment" do
      get :new, {}, valid_session
      expect(assigns(:environment)).to be_a_new(Environment)
    end
  end

  describe "GET #edit" do
    it "assigns the requested environment as @environment" do
      environment = Environment.create! valid_attributes
      get :edit, {:id => environment.to_param}, valid_session
      expect(assigns(:environment)).to eq(environment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new environment" do
        expect {
          post :create, {:environment => valid_attributes}, valid_session
        }.to change(Environment, :count).by(1)
      end

      it "assigns a newly created environment as @environment" do
        post :create, {:environment => valid_attributes}, valid_session
        expect(assigns(:environment)).to be_a(Environment)
        expect(assigns(:environment)).to be_persisted
      end

      it "redirects to the environments list" do
        post :create, {:environment => valid_attributes}, valid_session
        expect(response).to redirect_to(environments_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved environment as @environment" do
        post :create, {:environment => invalid_attributes}, valid_session
        expect(assigns(:environment)).to be_a_new(Environment)
      end

      it "re-renders the 'new' template" do
        post :create, {:environment => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'extpxy002',
        }
      }

      it "updates the requested environment" do
        environment = Environment.create! valid_attributes
        put :update, {:id => environment.to_param, :environment => new_attributes}, valid_session
        environment.reload
        expect(environment.name).to eq('extpxy002')
      end

      it "assigns the requested environment as @environment" do
        environment = Environment.create! valid_attributes
        put :update, {:id => environment.to_param, :environment => valid_attributes}, valid_session
        expect(assigns(:environment)).to eq(environment)
      end

      it "redirects to the environments list" do
        environment = Environment.create! valid_attributes
        put :update, {:id => environment.to_param, :environment => valid_attributes}, valid_session
        expect(response).to redirect_to(environments_path)
      end
    end

    context "with invalid params" do
      it "assigns the environment as @environment" do
        environment = Environment.create! valid_attributes
        put :update, {:id => environment.to_param, :environment => invalid_attributes}, valid_session
        expect(assigns(:environment)).to eq(environment)
      end

      it "re-renders the 'edit' template" do
        environment = Environment.create! valid_attributes
        put :update, {:id => environment.to_param, :environment => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested environment" do
      environment = Environment.create! valid_attributes
      expect {
        delete :destroy, {:id => environment.to_param}, valid_session
      }.to change(Environment, :count).by(-1)
    end

    it "redirects to the environments list" do
      environment = Environment.create! valid_attributes
      delete :destroy, {:id => environment.to_param}, valid_session
      expect(response).to redirect_to(environments_url)
    end
  end
end
