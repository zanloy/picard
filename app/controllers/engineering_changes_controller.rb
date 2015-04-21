class EngineeringChangesController < ApplicationController

  before_filter :set_change, except: [:index, :new, :create]

  def index
    @changes = EngineeringChange.timeline.page(page_param)
  end

  def show
  end

  def new
    @change = EngineeringChange.new
    @pocs = User.enabled.sorted
  end

  def create
    EngineeringChange.create create_params
    redirect_to engineering_changes_path
  end

  def edit
    @pocs = User.enabled.sorted
  end

  def update
    if @change.update_attributes(create_params)
      redirect_to engineering_change_path(@change), notice: 'Update successful.'
    else
      redirect_to engineering_change_path(@change), error: 'Update failed.'
    end
  end

  def destroy
    @change.destroy
    redirect_to engineering_changes_path, notice: 'Engineering change deleted.'
  end

  private

  def set_change
    @change = EngineeringChange.find(params.require(:id))
  end

  def page_param
    if params.has_key? :page
      return params[:page]
    else
      return 1
    end
  end

  def create_params
    p = params.require(:engineering_change).permit(:poc_id, :when, :environment_id, :title, :description, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:poc_id] = session[:user_id] if (p[:poc_id].nil? or p[:poc_id].empty?)
    p[:when] = Time.now if not p.has_key? :when
    p
  end

end
