require 'rails_helper'

RSpec.describe 'servers/show', type: :view do
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
    @environment = create(:environment)
    @server = assign(:server, create(:server, environment_id: @environment.id))
  end

  it 'renders attributes' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Environment/)
    expect(rendered).to match(/IP Address/)
    expect(rendered).to match(/Ports/)
  end

  it 'renders values' do
    render
    expect(rendered).to have_content(@server.name)
    expect(rendered).to have_content(@environment.name)
    expect(rendered).to have_content(@server.ip_address)
    expect(rendered).to have_content(@server.ports)
  end
end
