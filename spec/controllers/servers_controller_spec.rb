require 'rails_helper'

RSpec.describe ServersController, type: :controller do

  context 'as an admin' do
    login_admin
    set_referer

    before(:each) do
      @server = create(:server)
    end

    describe "GET #index" do
      it "assigns all servers as @servers" do
        get :index, {}, @session
        expect(assigns(:servers)).to eq([@server])
      end
    end

    describe "GET #show" do
      it "assigns the requested server as @server" do
        get :show, {id: @server.to_param}, @session
        expect(assigns(:server)).to eq(@server)
      end
    end

    describe "GET #new" do
      it "assigns a new server as @server" do
        get :new, {}, @session
        expect(assigns(:server)).to be_a_new(Server)
      end
    end

    describe "GET #edit" do
      it "assigns the requested server as @server" do
        get :edit, {id: @server.to_param}, @session
        expect(assigns(:server)).to eq(@server)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Server" do
          expect {
            post :create, {server: attributes_for(:server)}, @session
          }.to change {Server.count}.by(1)
        end

        it "assigns a newly created server as @server" do
          post :create, {server: attributes_for(:server)}, @session
          expect(assigns(:server)).to be_a(Server)
          expect(assigns(:server)).to be_persisted
        end

        it "redirects to the created server" do
          post :create, {server: attributes_for(:server)}, @session
          expect(response).to redirect_to(Server.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved server as @server" do
          post :create, {server: attributes_for(:server, :invalid)}, @session
          expect(assigns(:server)).to be_a_new(Server)
        end

        it "re-renders the 'new' template" do
          post :create, {server: attributes_for(:server, :invalid)}, @session
          expect(response).to render_template('new')
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { name: 'extpxy002' } }

        it "updates the requested server" do
          put :update, {id: @server.to_param, server: new_attributes}, @session
          @server.reload
          expect(@server.name).to eq(new_attributes[:name])
        end

        it "assigns the requested server as @server" do
          put :update, {id: @server.to_param, server: @server.attributes}, @session
          expect(assigns(:server)).to eq(@server)
        end

        it "redirects to the server" do
          put :update, {id: @server.to_param, server: @server.attributes}, @session
          expect(response).to redirect_to(@server)
        end
      end

      context "with invalid params" do
        it "assigns the server as @server" do
          put :update, {id: @server.to_param, server: attributes_for(:server, :invalid)}, @session
          expect(assigns(:server)).to eq(@server)
        end

        it "re-renders the 'edit' template" do
          put :update, {id: @server.to_param, server: attributes_for(:server, :invalid)}, @session
          expect(response).to render_template('edit')
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested server" do
        expect {
          delete :destroy, {id: @server.to_param}, @session
        }.to change {Server.count}.by(-1)
      end

      it "redirects to the servers list" do
        delete :destroy, {id: @server.to_param}, @session
        expect(response).to redirect_to(servers_url)
      end
    end
  end # context 'as an admin'

  context 'as a user' do
    login_user
    set_referer

    before(:each) do
      @server = create(:server)
    end

    describe "GET #new" do
      it 'denies creation of a new Server' do
        get :new, {}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "GET #edit" do
      it 'denies an edit form' do
        get :edit, {id: @server.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "POST #create" do
      it 'does not create a new Server' do
        expect {
          post :create, {server: attributes_for(:server)}, @session
        }.not_to change {Server.count}
      end
      it 'redirects back' do
        post :create, {server: attributes_for(:server)}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "PUT #update" do
      let (:new_attributes) { { name: 'extpxy002' } }
      it 'does not update Server' do
        put :update, {id: @server.to_param, server: new_attributes}, @session
        @server.reload
        expect(@server.name).not_to eq(new_attributes[:name])
      end
      it 'redirects :back' do
        put :update, {id: @server.to_param, server: new_attributes}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "DELETE #destroy" do
      it 'does not destroy Server' do
        expect {
          delete :destroy, {id: @server.to_param}, @session
        }.not_to change {Server.count}
      end

      it 'redirects :back' do
        delete :destroy, {id: @server.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end # context 'as a user'

end
