# frozen_string_literal: true

# Controller for Comments
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  load_and_authorize_resource

  def create
    @commentable = find_commentable
    parameters = comment_params
    parameters[:user_id] = @current_user.id
    @comment = @commentable.comments.build(parameters)
    if @comment.save
      redirect_to :back, notice: 'Comment saved.'
    else
      redirect_to :back, error: 'There was an error while trying to save your comment.'
    end
  end

  def destroy
    respond_to do |format|
      if admin? || @comment.user == @current_user
        @comment.destroy
        format.html { redirect_to :back, notice: 'Comment deleted.' }
      else
        format.html { redirect_to :back, error: 'You do not have access to do that.' }
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_commentable
    params.each do |name, value|
      return Regex.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
