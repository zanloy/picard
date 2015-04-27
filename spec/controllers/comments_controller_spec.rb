require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ServersController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: 1 } }

  let(:valid_comment) { { comment: 'This is a test comment.' } }
  let(:commentable) do
    environment = Environment.create!({ name: 'Production', domain: 'prod.test.com' })
    change = EngineeringChange.create!({ entered_by_id: 1, poc_id: 1, environment_id: environment.id, when: Time.now, title: 'Testing'})
  end

  before(:each) do
      request.env["HTTP_REFERER"] = "http://test.host/"
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, { engineering_change_id: commentable.id, comment: valid_comment }, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, { engineering_change_id: commentable.id, comment: valid_comment }, valid_session
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "redirects to :back" do
        post :create, { engineering_change_id: commentable.id, comment: valid_comment }, valid_session
        expect(response).to redirect_to(:back)
      end
    end

  end
  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = commentable.comments.create! valid_comment.merge({user_id: 1})
      expect {
        delete :destroy, {:id => comment.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the servers list" do
      comment = commentable.comments.create! valid_comment.merge({user_id: 1})
      delete :destroy, {:id => comment.to_param}, valid_session
      expect(response).to redirect_to(:back)
    end
  end

end
