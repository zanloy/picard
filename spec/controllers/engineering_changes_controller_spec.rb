require 'rails_helper'

RSpec.describe EngineeringChangesController, type: :controller do

  context 'as an admin' do
    login_admin
    set_referer

    describe "GET #index" do
      it "assigns all servers as @changes" do
        change = create(:engineering_change)
        get :index, {}, @session
        expect(assigns(:changes)).to eq([change])
      end
    end

    describe "GET #show" do
      it "assigns the requested change as @change" do
        change = create(:engineering_change)
        get :show, {id: change.to_param}, @session
        expect(assigns(:change)).to eq(change)
      end
    end

    describe "GET #new" do
      it "assigns a new server as @change" do
        get :new, {}, @session
        expect(assigns(:change)).to be_a_new(EngineeringChange)
      end
    end

    describe "GET #edit" do
      it "assigns the requested change as @change" do
        change = create(:engineering_change)
        get :edit, {id: change.to_param}, @session
        expect(assigns(:change)).to eq(change)
      end
    end

    describe "POST #create" do
      context "with valid params" do

        it "creates a new EngineeringChange" do
          expect do
            post :create, {engineering_change: attributes_for(:engineering_change)}, @session
          end.to change {EngineeringChange.count}.by(1)
        end

        it "assigns a newly created change as @change" do
          post :create, {engineering_change: attributes_for(:engineering_change)}, @session
          expect(assigns(:change)).to be_a(EngineeringChange)
          expect(assigns(:change)).to be_persisted
        end

        it "redirects to the created change" do
          post :create, {engineering_change:  attributes_for(:engineering_change)}, @session
          expect(response).to redirect_to(engineering_changes_url)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved change as @change" do
          post :create, {engineering_change: attributes_for(:engineering_change, :invalid)}, @session
          expect(assigns(:change)).to be_a_new(EngineeringChange)
        end

        it "re-renders the 'new' template" do
          post :create, {engineering_change: attributes_for(:engineering_change, :invalid)}, @session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      before(:each) { @change = create(:engineering_change) }
      context "with valid params" do
        let(:new_attributes) { { title: 'Updated change title!' } }
        it "updates the requested change" do
          put :update, {id: @change.to_param, engineering_change: new_attributes}, @session
          @change.reload
          expect(@change.title).to eq('Updated change title!')
        end

        it "assigns the requested change as @change" do
          put :update, {id: @change.to_param, engineering_change: @change.attributes}, @session
          expect(assigns(:change)).to eq(@change)
        end

        it "redirects to the change" do
          put :update, {id: @change.to_param, engineering_change: @change.attributes}, @session
          expect(response).to redirect_to(@change)
        end
      end

      context "with invalid params" do
        it "assigns the change as @change" do
          put :update, {id: @change.to_param, engineering_change: attributes_for(:engineering_change, :invalid)}, @session
          expect(assigns(:change)).to eq(@change)
        end

        it "re-renders the 'edit' template" do
          put :update, {id: @change.to_param, engineering_change: attributes_for(:engineering_change, :invalid)}, @session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      before(:each) { @change = create(:engineering_change) }
      it "destroys the requested change" do
        expect {
          delete :destroy, {id: @change.to_param}, @session
        }.to change {EngineeringChange.count}.by(-1)
      end

      it "redirects to the changes list" do
        delete :destroy, {id: @change.to_param}, @session
        expect(response).to redirect_to(engineering_changes_url)
      end
    end
  end

  context 'as the poc' do
    login_user
    set_referer

    before(:each) do
      @change = create(:engineering_change, poc_id: @user.id)
    end

    describe "GET #edit" do
      it "assigns the requested change as @change" do
        get :edit, {id: @change.to_param}, @session
        expect(assigns(:change)).to eq(@change)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { title: 'Updated change title!' } }
        it "updates the requested change" do
          put :update, {id: @change.to_param, engineering_change: new_attributes}, @session
          @change.reload
          expect(@change.title).to eq('Updated change title!')
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested change" do
        expect {
          delete :destroy, {id: @change.to_param}, @session
        }.to change {EngineeringChange.count}.by(-1)
      end
    end
  end

  context 'as a user (not poc)' do
    login_user
    set_referer

    before(:each) do
      second_user = create(:user)
      @change = create(:engineering_change, entered_by_id: second_user.id, poc_id: second_user.id)
    end

    describe "GET #edit" do
      it 'denies an edit form' do
        get :edit, {id: @change.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) { { title: 'Updated change title!' } }
      it 'denies the change' do
        put :update, {id: @change.to_param, engineering_change: new_attributes}, @session
        @change.reload
        expect(@change.title).not_to eq('Updated change title!')
      end
    end

    describe "DELETE #destroy" do
      it 'denies destruction' do
        expect do
          delete :destroy, {id: @change.to_param}, @session
        end.not_to change {EngineeringChange.count}
      end
      it 'redirects :back' do
        delete :destroy, {id: @change.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end

end
