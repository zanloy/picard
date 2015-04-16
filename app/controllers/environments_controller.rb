class EnvironmentsController < ApplicationController

  before_filter :require_admin, except: [:index, :show]

  def index
    @environment = Environment.new # For quick add form
    @environments = Environment.all
  end

  def show
    @environment = Environment.find(edit_params)
    @logitems = @environment.log_items.order(when: :desc).limit(25)
  end

  def new
    @environment = Environment.new
  end

  def create
    Environment.create create_params
    redirect_to :back, notice: 'Environment created successfully.'
  end

  def edit
    @environment = Environment.find(edit_params)
  end

  def destroy
    Environment.destroy(edit_params)
    redirect_to environments_path, notice: 'Environment deleted.'
  end

  def update
    environment = Environment.find(edit_params)
    if environment.update_attributes(create_params)
      redirect_to environments_path, notice: 'Environment was successfully updated.'
    else
      redirect_to :back, notice: 'There was an error updating environment.'
    end
  end

  private

  def create_params
    params.require(:environment).permit(:name)
  end

  def edit_params
    params.require(:id)
  end

end
