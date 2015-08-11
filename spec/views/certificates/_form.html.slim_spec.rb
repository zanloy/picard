require 'rails_helper'

RSpec.describe '/certificates/_form', type: :view do

  include RSpecHtmlMatchers

  it 'renders a certificate form' do
    assign(:certificate, Certificate.new)
    render partial: 'form'
    expect(rendered).to have_tag('form', with: {action: certificates_path(@list), method: 'post'}) do
      with_text_area 'certificate[pem]'
    end
  end
end
