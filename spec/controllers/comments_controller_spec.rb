require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  context 'as an admin' do
    login_admin
    set_referer

    let(:commentable) { create(:engineering_change) }

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Comment" do
          expect {
            post :create, {engineering_change_id: commentable.to_param, comment: attributes_for(:comment)}, @session
          }.to change {Comment.count}.by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment)}, @session
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to :back" do
          post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment)}, @session
          expect(response).to redirect_to(:back)
        end
      end
      context 'with invalid params' do
        it 'denies creation of Comment' do
          expect do
            post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment, :invalid)}, @session
          end.not_to change {Comment.count}
        end
        it 'redirects :back' do
          post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment, :invalid)}, @session
          expect(response).to redirect_to(:back)
        end
      end

    end
    describe "DELETE #destroy" do

      before(:each) do
        @comment = create(:comment, commentable: commentable, user: @current_user)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, {id: @comment.to_param}, @session
        }.to change {Comment.count}.by(-1)
      end

      it "redirects to the servers list" do
        delete :destroy, {id: @comment.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end #context 'as an admin'

  context 'as the comment owner' do
    login_user
    set_referer

    let(:commentable) { create(:engineering_change) }

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Comment" do
          expect {
            post :create, {engineering_change_id: commentable.to_param, comment: attributes_for(:comment)}, @session
          }.to change {Comment.count}.by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment)}, @session
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to :back" do
          post :create, {engineering_change_id: commentable.id, comment: attributes_for(:comment)}, @session
          expect(response).to redirect_to(:back)
        end
      end

    end
    describe "DELETE #destroy" do
      before(:each) do
        @comment = create(:comment, commentable: commentable, user: @current_user)
      end
      it "destroys the requested comment" do
        expect {
          delete :destroy, {id: @comment.to_param}, @session
        }.to change {Comment.count}.by(-1)
      end

      it "redirects to the servers list" do
        delete :destroy, {id: @comment.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end #context 'as the comment owner'

  context 'as an admin' do
    login_user
    set_referer

    let(:commentable) { create(:engineering_change) }

    before(:each) do
      second_user = create(:user)
      @comment = create(:comment, commentable: commentable, user: second_user)
    end

    describe "DELETE #destroy" do
      it 'denies destruction' do
        expect {
          delete :destroy, {id: @comment.to_param}, @session
        }.not_to change {Comment.count}
      end
      it 'redirects :back' do
        delete :destroy, {id: @comment.to_param}, @session
        expect(response).to redirect_to(:back)
      end
    end
  end #context 'as a user (not owner)'

end
