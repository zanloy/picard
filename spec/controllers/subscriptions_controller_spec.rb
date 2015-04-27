require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ServersController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: 1 } }

  let(:subscribable) do
    environment = Environment.create!({ name: 'Production', domain: 'prod.test.com' })
    change = EngineeringChange.create!({ entered_by_id: 1, poc_id: 1, environment_id: environment.id, when: Time.now, title: 'Testing'})
  end

  before(:each) do
      request.env["HTTP_REFERER"] = "http://test.host/"
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, { engineering_change_id: subscribable.id }, valid_session
        }.to change(Subscription, :count).by(1)
      end

      it "assigns a newly created server as @subscription" do
        post :create, { engineering_change_id: subscribable.id }, valid_session
        expect(assigns(:subscription)).to be_a(Subscription)
        expect(assigns(:subscription)).to be_persisted
      end

      it "redirects to :back" do
        post :create, { engineering_change_id: subscribable.id }, valid_session
        expect(response).to redirect_to(:back)
      end
    end

  end
  describe "DELETE #destroy" do
    it "destroys the requested subscription" do
      subscription = subscribable.subscriptions.create!({ user_id: 1 })
      expect {
        delete :destroy, {:id => subscription.to_param}, valid_session
      }.to change(Subscription, :count).by(-1)
    end

    it "redirects to the servers list" do
      subscription = subscribable.subscriptions.create!({ user_id: 1 })
      delete :destroy, {:id => subscription.to_param}, valid_session
      expect(response).to redirect_to(:back)
    end
  end

end
