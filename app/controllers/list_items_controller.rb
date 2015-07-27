class ListItemsController < ApplicationController

  before_action :set_list, only: :create

  def create
    parameters = list_item_params
    parameters[:list] = @list
    parameters[:updated_by_id] = @current_user.id
    list_item = ListItem.new(parameters)
    if list_item.save
      redirect_to @list
    else
      redirect_to @list, alert: 'There was an error while trying to save your comment.'
    end
  end

  def destroy
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def permitted_fields
    @list.fields
  end

  def list_item_params
    params.require(:list_item).permit(permitted_fields)
  end

end
