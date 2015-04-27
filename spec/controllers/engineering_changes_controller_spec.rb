require 'rails_helper'

RSpec.describe EngineeringChangesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Server. As you add validations to Server, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    environment = Environment.create!({name: 'Test'})
    {
      entered_by_id: 1,
      poc_id: 1,
      when: Time.now,
      environment_id: environment.id,
      title: 'Test Change for RSpec.',
      description: 'This is a long description.',
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      invalid: true,
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ServersController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: 1 } }

  describe "GET #index" do
    it "assigns all servers as @changes" do
      change = EngineeringChange.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:changes)).to eq([change])
    end
  end

  describe "GET #show" do
    it "assigns the requested change as @change" do
      change = EngineeringChange.create! valid_attributes
      get :show, {:id => change.to_param}, valid_session
      expect(assigns(:change)).to eq(change)
    end
  end

  describe "GET #new" do
    it "assigns a new server as @change" do
      get :new, {}, valid_session
      expect(assigns(:change)).to be_a_new(EngineeringChange)
    end
  end

  describe "GET #edit" do
    it "assigns the requested change as @change" do
      change = EngineeringChange.create! valid_attributes
      get :edit, {:id => change.to_param}, valid_session
      expect(assigns(:change)).to eq(change)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new EngineeringChange" do
        expect {
          post :create, {engineering_change: valid_attributes}, valid_session
        }.to change(EngineeringChange, :count).by(1)
      end

      it "assigns a newly created change as @change" do
        post :create, {engineering_change: valid_attributes}, valid_session
        expect(assigns(:change)).to be_a(EngineeringChange)
        expect(assigns(:change)).to be_persisted
      end

      it "redirects to the created change" do
        post :create, {engineering_change:  valid_attributes}, valid_session
        expect(response).to redirect_to(engineering_changes_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved change as @change" do
        post :create, {engineering_change: invalid_attributes}, valid_session
        expect(assigns(:change)).to be_a_new(EngineeringChange)
      end

      it "re-renders the 'new' template" do
        post :create, {engineering_change: invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title: 'Updated change title!',
        }
      }

      it "updates the requested change" do
        change = EngineeringChange.create! valid_attributes
        put :update, {id: change.to_param, engineering_change: new_attributes}, valid_session
        change.reload
        expect(change.title).to eq('Updated change title!')
      end

      it "assigns the requested change as @change" do
        change = EngineeringChange.create! valid_attributes
        put :update, {id: change.to_param, engineering_change: valid_attributes}, valid_session
        expect(assigns(:change)).to eq(change)
      end

      it "redirects to the change" do
        change = EngineeringChange.create! valid_attributes
        put :update, {id: change.to_param, engineering_change: valid_attributes}, valid_session
        expect(response).to redirect_to(change)
      end
    end

    context "with invalid params" do
      it "assigns the change as @change" do
        change = EngineeringChange.create! valid_attributes
        put :update, {id: change.to_param, engineering_change: invalid_attributes}, valid_session
        expect(assigns(:change)).to eq(change)
      end

      it "re-renders the 'edit' template" do
        change = EngineeringChange.create! valid_attributes
        put :update, {id: change.to_param, engineering_change: invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested change" do
      change = EngineeringChange.create! valid_attributes
      expect {
        delete :destroy, {id: change.to_param}, valid_session
      }.to change(EngineeringChange, :count).by(-1)
    end

    it "redirects to the changes list" do
      change = EngineeringChange.create! valid_attributes
      delete :destroy, {id: change.to_param}, valid_session
      expect(response).to redirect_to(engineering_changes_url)
    end
  end

end
