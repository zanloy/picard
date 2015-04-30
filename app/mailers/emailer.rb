class Emailer < ActionMailer::Base

  default from: ENV['GMAIL_ADDRESS']

  def new_comment(user, comment)
    @user = user
    @comment = comment
    @commentable = @comment.commentable
    mail(to: @user.email, subject: "New comment on #{@commentable.title.truncate(50)}")
  end

  def new_change(user, change)
    @user = user
    @change = change
    mail(to: @user.email, subject: "New Change: #{@change.title.truncate(50)}")
  end

  def new_user(user, new_user)
    @user = user
    @new_user = new_user
    mail(to: @user.email, subject: "New User: #{@new_user.name_or_email}")
  end

end
