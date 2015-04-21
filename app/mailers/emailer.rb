class Emailer < ActionMailer::Base

  default from: ENV['GMAIL_ADDRESS']

  def new_comment(user, comment)
    @user = user
    @comment = comment
    @commentable = @comment.commentable
    mail(to: @user.email, subject: "New comment on #{@commentable.title.truncate(50)}")
  end

end
