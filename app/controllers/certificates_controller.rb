class CertificatesController < ApplicationController

  before_action :set_certificate, except: [:index, :new, :create]

  load_and_authorize_resource
  
  def index
    @certificates = Certificate.sorted
  end

  def show
  end

  def new
    @certificate = Certificate.new
  end

  def create
    @certificate = Certificate.new(create_params)

    respond_to do |format|
      if @certificate.save
        format.html { redirect_to certificates_path, notice: 'Certificate saved.' }
        format.json { render :show, status: :created, location: @certificate }
      else
        format.html { render :new, alert: 'Certificate failed to save.' }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    @certificate.destroy

    respond_to do |format|
      format.html { redirect_to certificates_path, notice: 'Certificate was deleted.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @certificate.update_attributes(create_params)
        format.html { redirect_to @certificate, notice: 'Certificate updated.' }
        format.json { render :show, status: :ok, location: @certificate }
      else
        format.html { render :edit, notice: 'There was an error updating the certificate.' }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def create_params
    params.require(:certificate).permit(:pem)
  end

end
