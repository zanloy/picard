require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  let(:server) { create(:server) }
  let(:certificate) { create(:certificate) }
  let(:add_cert_payload) {
    {
      api_key: server.api_key,
      format: :json,
      certificate: {
        pem: certificate.pem,
        filename: '/tmp/test.crt',
      }
    }
  }

  describe 'POST #add_cert' do
    context 'cert does not already exist' do
      it 'adds a cert' do
        expect {
          post :add_cert, add_cert_payload
        }.to change{Certificate.count}.by 1
      end
    end

    context 'location does not already exist' do
      it 'adds a cert_location' do
        expect {
          post :add_cert, add_cert_payload
        }.to change{CertificateLocation.count}.by 1
      end
    end

    context 'location already exists' do
      it 'updates the timestamp' do
        location = server.certificate_locations.create(certificate: certificate, location: '/tmp/test.crt')
        original = location.updated_at
        post :add_cert, add_cert_payload
        #puts "original = #{original}, new = #{location.updated_at}"
        #puts original == location.updated_at ? "TRUE" : "FALSE"
        expect(location.updated_at).not_to eq(original)
      end
    end

    #it 'returns http success' do
    #  post :add_cert
    #  expect(response).to have_http_status(:success)
    #end
  end

end
