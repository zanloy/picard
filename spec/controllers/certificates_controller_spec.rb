require 'rails_helper'

RSpec.describe CertificatesController, type: :controller do

  login_admin

  shared_examples_for 'it assigns @certificate' do
    it 'assigns @certificate' do
      case location
      when :destroy
        delete :destroy, { id: @certificate.to_param }, @session
      when :update
        put :update, { id: @certificate.to_param, certificate: update_params }, @session
      else
        get location, { id: @certificate.to_param }, @session
      end
      expect(assigns(:certificate)).to eql(@certificate)
    end
  end

  context 'where certificate exists' do
    before(:each) { @certificate = create(:certificate) }

    describe 'GET #index' do
      it 'assigns all certificates to @certificates' do
        get :index, {}, @session
        expect(assigns(:certificates)).to match_array([@certificate])
      end
    end

    describe 'GET #show' do
      let(:location) { :show }
      it_behaves_like 'it assigns @certificate'
    end

    describe 'GET #edit' do
      let(:location) { :edit }
      it_behaves_like 'it assigns @certificate'
    end

    describe 'GET #destroy' do
      let(:location) { :destroy }
      it_behaves_like 'it assigns @certificate'

      it 'destroys the certificate' do
        expect {
          delete :destroy, { id: @certificate.to_param }, @session
        }.to change{Certificate.count}.by(-1)
      end

      it 'redirects to #index' do
        delete :destroy, { id: @certificate.to_param }, @session
        expect(response).to redirect_to(certificates_path)
      end
    end

    describe 'PUT #update' do
      let(:location) { :update }
      let(:update_params) { attributes_for(:certificate, :test2) }
      it_behaves_like 'it assigns @certificate'

      it 'updates the certificate' do
        put :update, { id: @certificate.to_param, certificate: update_params }, @session
        @certificate.reload
        expect(@certificate.cn).to eql('Picard Test Certificate 2')
      end

      it 'redirects to #show' do
        put :update, { id: @certificate.to_param, certificate: update_params }, @session
        expect(response).to redirect_to(certificate_path(@certificate))
      end
    end
  end

  describe 'GET #new' do
    it 'assigns @certicate to a new certificate' do
      get :new, {}, @session
      expect(assigns(:certificate)).to be_a_new(Certificate)
    end
  end

  describe 'GET #create' do
    it 'creates a new certificate' do
      expect {
        post :create, { certificate: attributes_for(:certificate) }, @session
      }.to change{Certificate.count}.by(1)
    end

    it 'redirects to #show for the new certificate' do
      post :create, { certificate: attributes_for(:certificate) }, @session
      expect(response).to redirect_to(certificates_path)
    end
  end
end
