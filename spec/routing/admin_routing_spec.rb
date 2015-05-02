require "rails_helper"

RSpec.describe AdminController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/admin").to route_to("admin#index")
    end

    it 'routes to #enable_user' do
      expect(get: '/admin/enable_user/1').to route_to('admin#enable_user', user_id: '1')
    end
    
  end
end
