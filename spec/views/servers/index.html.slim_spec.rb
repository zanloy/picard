require 'rails_helper'

RSpec.describe 'servers/index', type: :view do
  before do
    controller.singleton_class.class_eval do
      protected
      def is_admin?
        true
      end
      helper_method :is_admin?
    end
  end

  before(:each) do
    @servers = []
    @environments = create_pair(:environment)
    @environments.each do |environment|
      3.times do
        @servers << create(:server, environment_id: environment.id)
      end
    end
    assign(:servers, @servers)
    render
  end

  it 'renders the environments' do
    @environments.each do |environment|
      assert_select 'h2', text: environment.name
    end
  end

  it 'renders values' do
    @servers.each do |server|
      assert_select "tr#server_#{server.id}" do
        assert_select 'td', text: server.name
        assert_select 'td', text: server.environment.name
        assert_select 'td', text: server.ip_address
        assert_select 'td', text: server.ports
      end
    end
  end
end
