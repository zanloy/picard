# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "certificates/show.html.slim", type: :view do

  include RSpecHtmlMatchers

  before do
    @user = create(:user)
    controller.singleton_class.class_eval do
      protected
      def current_user
        @user
      end
      def is_admin?
        true
      end
      helper_method :is_admin?
    end
  end

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
  it { expect(rendered).to match(@certificate.poc) }

end
