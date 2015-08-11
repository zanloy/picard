require 'rails_helper'

RSpec.describe "certificates/show.html.slim", type: :view do

  include RSpecHtmlMatchers

  before(:each) do
    @certificate = assign(:certificate, create(:certificate))
    render
  end

  it { expect(rendered).to match(@certificate.cn) }
  it { expect(rendered).to match(@certificate.subject) }
  it { expect(rendered).to match(@certificate.issuer) }
  it { expect(rendered).to match(@certificate.not_before.strftime('%Y-%m-%d')) }
  it { expect(rendered).to match(@certificate.not_after.strftime('%Y-%m-%d')) }
  it { expect(rendered).to match(@certificate.signature_algorithm) }
  it { expect(rendered).to match(@certificate.key_length.to_s) }

end
