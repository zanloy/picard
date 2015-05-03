require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  login_user

  describe 'GET #index' do
    it 'assigns all tags to @tags' do
      tags = create_pair(:tag)
      get :index, {}, @session
      expect(assigns(:tags)).to match_array(tags)
    end
  end

  describe 'GET #show' do
    it 'assigns requested tag as @tag' do
      tag = create(:tag)
      get :show, {name: tag.name}, @session
      expect(assigns(:tag)).to eq(tag)
    end
  end

end
