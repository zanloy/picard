require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context 'as an admin' do
    login_admin
    set_referer

    before(:each) do
      @created_user = create(:user)
    end

    describe 'GET #index' do
      it 'assigns all users as @users' do
        get :index, {}, @session
        expect(assigns(:users)).to match_array([@user, @created_user])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested user as @user' do
        get :show, {id: @created_user.id}, @session
        expect(assigns(:user)).to eq(@created_user)
      end
    end

    describe 'GET #new' do
      it 'assigns a new user as @user' do
        get :new, {}, @session
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested user as @user' do
        get :edit, {id: @created_user.to_param}, @session
        expect(assigns(:user)).to eq(@created_user)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates the new user' do
          expect {
            post :create, {user: attributes_for(:user)}, @session
          }.to change {User.count}.by(1)
        end
        it 'assigns the newly created user as @user' do
          post :create, {user: attributes_for(:user)}, @session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end
        it 'redirects to the newly created user' do
          post :create, {user: attributes_for(:user)}, @session
          expect(response).to redirect_to(User.last)
        end
      end
      context 'with sparcedge.com email address' do
        it 'should redirect to signin_path with error' do
          post :create, {user: attributes_for(:user, email: 'user@sparcedge.com')}
          expect(response).to redirect_to(signin_path)
        end
      end
      context 'with invalid params' do
        it 'assigns a newly created but unsaved user as @user' do
          post :create, {user: attributes_for(:user, :invalid)}, @session
          expect(assigns(:user)).to be_a_new(User)
        end
        it 're-renders the :new template' do
          post :create, {user: attributes_for(:user, :invalid)}, @session
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) { { name: 'Johnny McIntosh' } }
        it 'updates the user' do
          put :update, {id: @created_user.to_param, user: new_attributes}, @session
          @created_user.reload
          expect(@created_user.name).to eq(new_attributes[:name])
        end
        it 'assigns the updated user as @user' do
          put :update, {id: @created_user.to_param, user: @created_user.attributes}, @session
          expect(assigns(:user)).to eq(@created_user)
        end
        it 'redirects to the updated user' do
          put :update, {id: @created_user.to_param, user: @created_user.attributes}, @session
          expect(response).to redirect_to(@created_user)
        end
      end

      context 'with invalid params' do
        it 'does not update the user' do
          put :update, {id: @created_user.to_param, user: attributes_for(:user, :invalid)}, @session
          @created_user.reload
          expect(@created_user).to eq(@created_user)
        end
        it 'assigns the user as @user' do
          put :update, {id: @created_user.to_param, user: attributes_for(:user, :invalid)}, @session
          expect(assigns(:user)).to eq(@created_user)
        end
        it 're-renders the :edit template' do
          put :update, {id: @created_user.to_param, user: attributes_for(:user, :invalid)}, @session
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the user' do
        expect {
          delete :destroy, {id: @created_user.to_param}, @session
        }.to change {User.count}.by(-1)
      end
      it 'redirects to the users_path' do
        delete :destroy, {id: @created_user.to_param}, @session
        expect(response).to redirect_to(users_path)
      end
    end
  end # context 'as an admin'
end
