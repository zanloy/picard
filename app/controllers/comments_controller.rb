class CommentsController < ApplicationController

  before_action :set_comment, only: [:update, :destroy]

  def create
    @commentable = find_commentable
    parameters = comment_params
    parameters[:user_id] = @current_user[:id]
    @comment = @commentable.comments.build(parameters)
    if @comment.save
      @commentable.subscriptions.each do |subscription|
        NewCommentEmailJob.set(wait: 20.seconds).perform_later(subscription.user, @comment)
        #Emailer.new_comment(subscription.user, @comment).deliver
      end
      redirect_to :back, notice: 'Comment saved.'
    else
      redirect_to :back, error: 'There was an error while trying to save your comment.'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
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
