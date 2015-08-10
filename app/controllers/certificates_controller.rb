class CertificatesController < ApplicationController

  before_action :set_certificate, except: [:index, :new, :create]

  def index
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
  end

  def update
  end

  private

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def create_params
    #params.require(:certificate).permit(:pem)
  end

end
