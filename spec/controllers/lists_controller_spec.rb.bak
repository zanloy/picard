# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  login_admin
  before(:each) { @list = create(:list) }

  describe 'GET #index' do
    it 'assigns all lists as @lists' do
      @lists = [@list, create_pair(:list)].flatten
      get :index, {}, @session
      expect(assigns(:lists)).to match_array(@lists)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested list as @list' do
      get :show, { id: @list.to_param}, @session
      expect(assigns(:list)).to eq(@list)
    end
  end

  describe 'GET #new' do
    it 'assigns a new list as @list' do
      get :new, {}, @session
      expect(assigns(:list)).to be_a_new(List)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested list as @list' do
      get :edit, { id: @list.to_param}, @session
      expect(assigns(:list)).to eq(@list)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new List' do
        expect {
          post :create, { list: attributes_for(:list) }, @session
        }.to change(List, :count).by(1)
      end

      it 'assigns a newly created list as @list' do
        post :create, { list: attributes_for(:list) }, @session
        expect(assigns(:list)).to be_a(List)
        expect(assigns(:list)).to be_persisted
      end

      it 'redirects to the created list' do
        post :create, { list: attributes_for(:list) }, @session
        expect(response).to redirect_to(List.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved list as @list' do
        post :create, { list: attributes_for(:list, :invalid) }, @session
        expect(assigns(:list)).to be_a_new(List)
      end

      it 're-renders the :new template' do
        post :create, { list: attributes_for(:list, :invalid) }, @session
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:list, name: 'New Name') }

      it 'updates the requested list' do
        put :update, { id: @list.to_param, list: new_attributes }, @session
        @list.reload
        expect(@list.name).to eq('New Name')
      end

      it 'assigns the requested list as @list' do
        put :update, { id: @list.to_param, list: new_attributes }, @session
        expect(assigns(:list)).to eq(@list)
      end

      it 'redirects to the list' do
        put :update, { id: @list.to_param, list: new_attributes}, @session
        expect(response).to redirect_to(@list)
      end
    end

    context 'with invalid params' do
      it 'assigns the list as @list' do
        put :update, { id: @list.to_param, list: attributes_for(:list, :invalid) }, @session
        expect(assigns(:list)).to eq(@list)
      end

      it 're-renders the :edit template' do
        put :update, { id: @list.to_param, list: attributes_for(:list, :invalid) }, @session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested list' do
      expect {
        delete :destroy, { id: @list.to_param}, @session
      }.to change(List, :count).by(-1)
    end

    it 'redirects to the lists list' do
      delete :destroy, { id: @list.to_param}, @session
      expect(response).to redirect_to(lists_path)
    end
  end

end
