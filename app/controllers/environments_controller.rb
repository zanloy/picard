class EnvironmentsController < ApplicationController

  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  before_filter :require_admin, except: [:index, :show]

  def index
    @environment = Environment.new # For quick add form
    @environments = Environment.all.order(:name)
  end

  def show
    @servers = @environment.servers.order(:name).limit(25)
    @changes = @environment.engineering_changes.timeline.limit(5)
  end

  def new
    @environment = Environment.new
  end

  def create
    @environment = Environment.new(create_params)

    respond_to do |format|
      if @environment.save
        format.html { redirect_to environments_path, notice: 'Environment created successfully.' }
        format.json { render :show, status: :created, location: @environment }
      else
        format.html { render :new, error: 'Environment failed to save.' }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    @environment.destroy
    respond_to do |format|
      format.html { redirect_to environments_url, notice: 'Environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @environment.update_attributes(create_params)
        format.html { redirect_to environments_path, notice: 'Environment was successfully updated.' }
        format.json { render :show, status: :ok, location: @environment }
      else
        format.html { render :edit, notice: 'There was an error updating environment.' }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_environment
    @environment = Environment.find(params[:id])
  end

  def create_params
    params.require(:environment).permit(:name, :domain)
  end

end
