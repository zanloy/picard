# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  let(:subscribable) { create(:engineering_change) }

  login_user
  set_referer

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, { engineering_change_id: subscribable.id }, @session
        }.to change {Subscription.count}.by(1)
      end

      it "assigns a newly created server as @subscription" do
        post :create, { engineering_change_id: subscribable.id }, @session
        expect(assigns(:subscription)).to be_a(Subscription)
        expect(assigns(:subscription)).to be_persisted
      end

      it "redirects to :back" do
        post :create, { engineering_change_id: subscribable.id }, @session
        expect(response).to redirect_to(:back)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested subscription" do
      subscription = subscribable.subscriptions.create!({ user_id: @current_user.id })
      expect {
        delete :destroy, {id: subscription.to_param}, @session
      }.to change {Subscription.count}.by(-1)
    end

    it "redirects to the servers list" do
      subscription = subscribable.subscriptions.create!({ user_id: @current_user.id })
      delete :destroy, {id: subscription.to_param}, @session
      expect(response).to redirect_to(:back)
    end
  end

end
