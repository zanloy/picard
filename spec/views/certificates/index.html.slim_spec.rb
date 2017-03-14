# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "certificates/index.html.slim", type: :view do

  include RSpecHtmlMatchers

  before(:each) do
    @certificates = [create(:certificate), create(:certificate, :test2)]
    assign(:certificates, @certificates)
    render
  end

  it 'renders a list of certificates' do
    @certificates.each do |certificate|
      expect(rendered).to have_tag(:tr) do
        with_tag(:td) do
          with_tag(:a, href: certificate_path(certificate), text: certificate.cn)
        end
        with_tag(:td, text: certificate.not_before.strftime('%Y-%m-%d'))
        with_tag(:td, text: certificate.not_after.strftime('%Y-%m-%d'))
      end
    end
  end

end
