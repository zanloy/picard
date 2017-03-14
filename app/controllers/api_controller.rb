# frozen_string_literal: true
class ApiController < ApplicationController

  skip_before_action :require_login

  before_action :set_server_from_api_key

  def add_cert
    respond_to do |format|
      begin
        cert = Certificate.where(pem: cert_params[:pem]).first_or_create
        location = CertificateLocation.where(server: @server, certificate: cert, location: cert_params[:filename]).first_or_create
        location.touch
        format.html { render text: cert.to_json }
        format.json { render text: cert.to_json }
      end
    end
  end

  private

    def set_server_from_api_key
      @server = Server.find_by(api_key: params[:api_key])
      if @server == nil
        render text: 'Failed.'
      end
    end

    def cert_params
      params.require(:certificate).permit(:pem, :filename)
    end

end
