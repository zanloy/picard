require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do

  let(:invalid_attributes) {
    {
      name: nil,
      invalid: true,
    }
  }

  context 'as an admin' do
    login_admin
    set_referer

    describe "GET #index" do
      it "assigns all environments as @environments" do
        environment = create(:environment)
        get :index, {}, @session
        expect(assigns(:environments)).to eq([environment])
      end
    end

    describe "GET #show" do
      it "assigns the requested environment as @environment" do
        environment = create(:environment)
        get :show, {:id => environment.to_param}, @session
        expect(assigns(:environment)).to eq(environment)
      end
    end

    describe "GET #new" do
      it "assigns a new environment as @environment" do
        get :new, {}, @session
        expect(assigns(:environment)).to be_a_new(Environment)
      end
    end

    describe "GET #edit" do
      it "assigns the requested environment as @environment" do
        environment = create(:environment)
        get :edit, {id: environment.to_param}, @session
        expect(assigns(:environment)).to eq(environment)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new environment" do
          expect {
            post :create, {environment: attributes_for(:environment)}, @session
          }.to change{Environment.count}.by(1)
        end

        it "assigns a newly created environment as @environment" do
          post :create, {environment: attributes_for(:environment)}, @session
          expect(assigns(:environment)).to be_a(Environment)
          expect(assigns(:environment)).to be_persisted
        end

        it "redirects to the environments list" do
          post :create, {environment: attributes_for(:environment)}, @session
          expect(response).to redirect_to(environments_url)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved environment as @environment" do
          post :create, {environment: invalid_attributes}, @session
          expect(assigns(:environment)).to be_a_new(Environment)
        end

        it "re-renders the 'new' template" do
          post :create, {environment: invalid_attributes}, @session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      before(:each) { @environment = create(:environment) }
      context "with valid params" do
        let(:new_attributes) { { name: 'extpxy002' } }

        it "updates the requested environment" do
          put :update, {id: @environment.to_param, environment: new_attributes}, @session
          @environment.reload
          expect(@environment.name).to eq('extpxy002')
        end

        it "assigns the requested environment as @environment" do
          put :update, {id: @environment.to_param, environment: @environment.attributes}, @session
          expect(assigns(:environment)).to eq(@environment)
        end

        it "redirects to the environments list" do
          put :update, {id: @environment.to_param, environment: @environment.attributes}, @session
          expect(response).to redirect_to(environments_path)
        end
      end

      context "with invalid params" do
        it "assigns the environment as @environment" do
          put :update, {id: @environment.to_param, environment: invalid_attributes}, @session
          expect(assigns(:environment)).to eq(@environment)
        end

        it "re-renders the 'edit' template" do
          put :update, {id: @environment.to_param, environment: invalid_attributes}, @session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested environment" do
        environment = create(:environment)
        expect {
          delete :destroy, {:id => environment.to_param}, @session
        }.to change{Environment.count}.by(-1)
      end

      it "redirects to the environments list" do
        environment = create(:environment)
        delete :destroy, {:id => environment.to_param}, @session
        expect(response).to redirect_to(environments_url)
      end
    end
  end

  context 'as an user' do
    login_user
    set_referer

    describe "GET #index" do
      it "assigns all environments as @environments" do
        environment = create(:environment)
        get :index, {}, @session
        expect(assigns(:environments)).to eq([environment])
      end
    end

    describe "GET #show" do
      it "assigns the requested environment as @environment" do
        environment = create(:environment)
        get :show, {:id => environment.to_param}, @session
        expect(assigns(:environment)).to eq(environment)
      end
    end

    describe "GET #new" do
      it 'redirects :back' do
        get :new, {}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "GET #edit" do
      it 'redirects :back' do
        environment = create(:environment)
        get :edit, {id: environment.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "POST #create" do
      it 'redirects :back' do
        post :create, {environment: attributes_for(:environment)}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "PUT #update" do
      it 'redirects :back' do
        environment = create(:environment)
        put :update, {id: environment.to_param, environment: environment.attributes}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "DELETE #destroy" do
      it 'redirects :back' do
        environment = create(:environment)
        delete :destroy, {:id => environment.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end

end
