class ListItemsController < ApplicationController

  before_action :set_list_item, except: [:create]
  before_action :set_list, only: :create

  def create
    parameters = list_item_params
    parameters[:list] = @list
    parameters[:updated_by_id] = @current_user.id
    list_item = ListItem.new(parameters)
    if list_item.save
      redirect_to @list
    else
      redirect_to @list, alert: 'There was an error while trying to save your item.'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @list_item.update_attributes(list_item_params)
        format.html { redirect_to @list_item.list, notice: 'Update successful.' }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit, error: 'Update failed.' }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list_item.destroy
    respond_to do |format|
      format.html { redirect_to @list_item.list }
      format.json { head :no_content }
    end
  end

  private

  def set_list_item
    @list_item = ListItem.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def permitted_fields
    @list_item.list.fields
  end

  def list_item_params
    params.require(:list_item).permit(permitted_fields)
  end

end
