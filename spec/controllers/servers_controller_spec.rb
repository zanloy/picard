require 'rails_helper'

RSpec.describe ServersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Server. As you add validations to Server, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'extpxy001',
      environment_id: 1,
      ip_address: '192.168.0.1',
      ports: '80/tcp 443/tcp',
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
    it "assigns all servers as @servers" do
      server = Server.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:servers)).to eq([server])
    end
  end

  describe "GET #show" do
    it "assigns the requested server as @server" do
      server = Server.create! valid_attributes
      get :show, {:id => server.to_param}, valid_session
      expect(assigns(:server)).to eq(server)
    end
  end

  describe "GET #new" do
    it "assigns a new server as @server" do
      get :new, {}, valid_session
      expect(assigns(:server)).to be_a_new(Server)
    end
  end

  describe "GET #edit" do
    it "assigns the requested server as @server" do
      server = Server.create! valid_attributes
      get :edit, {:id => server.to_param}, valid_session
      expect(assigns(:server)).to eq(server)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Server" do
        expect {
          post :create, {:server => valid_attributes}, valid_session
        }.to change(Server, :count).by(1)
      end

      it "assigns a newly created server as @server" do
        post :create, {:server => valid_attributes}, valid_session
        expect(assigns(:server)).to be_a(Server)
        expect(assigns(:server)).to be_persisted
      end

      it "redirects to the created server" do
        post :create, {:server => valid_attributes}, valid_session
        expect(response).to redirect_to(Server.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved server as @server" do
        post :create, {:server => invalid_attributes}, valid_session
        expect(assigns(:server)).to be_a_new(Server)
      end

      it "re-renders the 'new' template" do
        post :create, {:server => invalid_attributes}, valid_session
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

      it "updates the requested server" do
        server = Server.create! valid_attributes
        put :update, {:id => server.to_param, :server => new_attributes}, valid_session
        server.reload
        expect(server.name).to eq('extpxy002')
      end

      it "assigns the requested server as @server" do
        server = Server.create! valid_attributes
        put :update, {:id => server.to_param, :server => valid_attributes}, valid_session
        expect(assigns(:server)).to eq(server)
      end

      it "redirects to the server" do
        server = Server.create! valid_attributes
        put :update, {:id => server.to_param, :server => valid_attributes}, valid_session
        expect(response).to redirect_to(server)
      end
    end

    context "with invalid params" do
      it "assigns the server as @server" do
        server = Server.create! valid_attributes
        put :update, {:id => server.to_param, :server => invalid_attributes}, valid_session
        expect(assigns(:server)).to eq(server)
      end

      it "re-renders the 'edit' template" do
        server = Server.create! valid_attributes
        put :update, {:id => server.to_param, :server => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested server" do
      server = Server.create! valid_attributes
      expect {
        delete :destroy, {:id => server.to_param}, valid_session
      }.to change(Server, :count).by(-1)
    end

    it "redirects to the servers list" do
      server = Server.create! valid_attributes
      delete :destroy, {:id => server.to_param}, valid_session
      expect(response).to redirect_to(servers_url)
    end
  end

end
